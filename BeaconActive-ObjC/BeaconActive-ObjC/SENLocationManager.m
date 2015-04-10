//
//  SENLocationManager.m
//  BeaconActive-ObjC
//
//  Created by skyming on 15/4/10.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

#import "SENLocationManager.h"
#import <UIKit/UIKit.h>

@interface SENLocationManager ()<CLLocationManagerDelegate>

@end

@implementation SENLocationManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    
    if(self = [super init])
    {
        _locationManager = [[CLLocationManager alloc]init];

        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [_locationManager requestAlwaysAuthorization];
        }
        _locationManager.delegate = self;
        _monitorRegion = [[CLBeaconRegion alloc]initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"46D06053-9FAD-483B-B704-E576735CE1A3"] identifier:@"SensoroBeaconActiveTest"];
                          
    }
    return self;
}


- (void)startMonitor:(BOOL)relaunch{
    
    if (!relaunch) {
        [_locationManager startMonitoringForRegion:_monitorRegion];
        NSLog(@"Start monitor region!");
    }else{
        NSLog(@"During the relauch app, don't restart monitor region!");

    }
    _started = true;

}

- (void)stopMonitor{
    [_locationManager stopMonitoringForRegion:_monitorRegion];
    _started = false;
    NSLog(@"Stop monitor region!");
}

- (void)sendNotification:(NSString *)notify{
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.alertBody = notify;
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY/MM/dd HH:mm:ss";
    
    switch (state) {
        case CLRegionStateInside:
            {
                NSString *alertbody =[NSString stringWithFormat:@"Enter region at %@",[formatter stringFromDate:now]];
                [self sendNotification:alertbody];
                NSLog(@"%@",alertbody);
            }
            break;
            
        case CLRegionStateOutside:
            {
                NSString *alertbody =[NSString stringWithFormat:@"Exit region at %@",[formatter stringFromDate:now]];
                [self sendNotification:alertbody];
                NSLog(@"%@",alertbody);
            }
        break;
    
        case CLRegionStateUnknown:
            NSLog(@"This region state was unknown!");
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"did Fail With Error %@", error.localizedDescription);
}

@end

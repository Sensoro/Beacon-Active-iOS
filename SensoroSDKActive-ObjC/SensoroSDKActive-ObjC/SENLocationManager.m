//
//  SENLocationManager.m
//  BeaconActive-ObjC
//
//  Created by skyming on 15/4/10.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

#import "SENLocationManager.h"
#import <UIKit/UIKit.h>

@interface SENLocationManager ()<SBKBeaconManagerDelegate>

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
        _locationManager = [SBKBeaconManager sharedInstance];

        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            //获取授权
            [_locationManager requestAlwaysAuthorization];
        }
        //设定代理
        _locationManager.delegate = self;
        //生成监测用的区域ID
        _monitorRegion = [SBKBeaconID beaconIDWithProximityUUID:[[NSUUID alloc]initWithUUIDString:@"46D06053-9FAD-483B-B704-E576735CE1A3"]];
        
    }
    return self;
}


- (void)startMonitor:(BOOL)relaunch{
    
    if (!relaunch) {
        [_locationManager startRangingBeaconsWithID:_monitorRegion wakeUpApplication:YES];
        NSLog(@"Start monitor region!");
    }else{
        NSLog(@"During the relauch app, don't restart monitor region!");

    }
    _started = true;

}

- (void)stopMonitor{
    [_locationManager stopRangingBeaconsWithID:_monitorRegion];
    _started = false;
    NSLog(@"Stop monitor region!");
}

- (void)sendNotification:(NSString *)notify{
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.alertBody = notify;
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}


- (void)beaconManager:(SBKBeaconManager *)beaconManager didRangeNewBeacon:(SBKBeacon *)beacon{
   
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY/MM/dd HH:mm:ss";
    
    NSLog(@"Enter: %@",now);
}

- (void)beaconManager:(SBKBeaconManager *)beaconManager beaconDidGone:(SBKBeacon *)beacon{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY/MM/dd HH:mm:ss";
    
    NSLog(@"Exit: %@",now);
}

- (void)beaconManager:(SBKBeaconManager *)beaconManager didDetermineState:(SBKRegionState)state forRegion:(SBKBeaconID *)region{
  
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

@end

//
//  SENLocationManager.h
//  BeaconActive-ObjC
//
//  Created by skyming on 15/4/10.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SENLocationManager : NSObject

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeaconRegion *monitorRegion;
@property (nonatomic) BOOL started;


+ (instancetype)sharedInstance;
- (void)startMonitor:(BOOL)relaunch;
- (void)stopMonitor;

@end

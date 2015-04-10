//
//  SENLocationManager.h
//  BeaconActive-ObjC
//
//  Created by skyming on 15/4/10.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SensoroBeaconKit/SensoroBeaconKit.h>

@interface SENLocationManager : NSObject

@property (nonatomic, strong) SBKBeaconManager *locationManager;
@property (nonatomic, strong) SBKBeaconID *monitorRegion;
@property (nonatomic) BOOL started;


+ (instancetype)sharedInstance;
- (void)startMonitor:(BOOL)relaunch;
- (void)stopMonitor;

@end

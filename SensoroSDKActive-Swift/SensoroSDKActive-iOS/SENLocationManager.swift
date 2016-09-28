//
//  SENLocationManager.swift
//  SensoroSDKActive-iOS
//
//  Created by David Yang on 15/4/8.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

import UIKit
import CoreLocation
import SensoroBeaconKit

//let _sharedInstance = SENLocationManager();

class SENLocationManager: NSObject, SBKBeaconManagerDelegate {
    
    static let sharedInstance = SENLocationManager()

    var started = false;
    var monitorRegion : SBKBeaconID!;

    
    private override init(){
        
        super.init();

        //设定代理
        SBKBeaconManager.sharedInstance().delegate = self;
        //获取授权
        SBKBeaconManager.sharedInstance().requestAlwaysAuthorization();
        //生成监测用的区域ID
        monitorRegion = SBKBeaconID(proximityUUID: UUID(uuidString: "46D06053-9FAD-483B-B704-E576735CE1A3"),major:0x23A2);
    }
    
    func startMonitor( relaunch : Bool ){
        if relaunch == false {
            SBKBeaconManager.sharedInstance().startRangingBeacons(with: monitorRegion, wakeUpApplication: true);
            NSLog("Start monitor region!");
        }else{
            NSLog("During the relauch app, don't restart monitor region!");
        }
        started = true;
    }
    
    
    func stopMonitor(){
        SBKBeaconManager.sharedInstance().stopRangingBeacons(with: monitorRegion);
        started = false;
        NSLog("Stop monitor region!");
    }
    
    func sendNotification(notify : String){
//        let notification = UILocalNotification()
//        notification.alertBody = notify
//        
//        notification.soundName = UILocalNotificationDefaultSoundName
//        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    // MARK: SBKBeaconManagerDelegate
    func beaconManager(_ beaconManager: SBKBeaconManager!, didRangeNewBeacon beacon: SBKBeacon!) {
//        let now = Date();
//        let formatter = DateFormatter();
//        formatter.dateFormat = "YYYY/MM/dd HH:mm:ss";
//        NSLog("Enter a beacon at \(formatter.string(from: now)), \(beacon.beaconID)");
    }
    
    func beaconManager(_ beaconManager: SBKBeaconManager!, beaconDidGone beacon: SBKBeacon!) {
//        let now = Date();
//        let formatter = DateFormatter();
//        formatter.dateFormat = "YYYY/MM/dd HH:mm:ss";
//        NSLog("Leave a beacon at \(formatter.string(from: now)), \(beacon.beaconID)");
    }
    
    func beaconManager(_ beaconManager: SBKBeaconManager!, scanDidFinishWithBeacons beacons: [Any]!) {
        //NSLog("Periodically call for scanDidFinishWithBeacons");
    }
    
    func beaconManager(_ beaconManager: SBKBeaconManager!, didDetermineState state : SBKRegionState, forRegion region : SBKBeaconID!) {
        
        switch state {
        case .enter:
            let now = Date();
            let formatter = DateFormatter();
            formatter.dateFormat = "YYYY/MM/dd HH:mm:ss";
            sendNotification(notify: "Enter region at \(formatter.string(from: now))");
            NSLog("Enter region at \(formatter.string(from: now))");
        case .leave:
            let now = Date();
            let formatter = DateFormatter();
            formatter.dateFormat = "YYYY/MM/dd HH:mm:ss";
            sendNotification(notify: "Exit  region at \(formatter.string(from: now))");
            NSLog("Exit  region at \(formatter.string(from: now))");
        case .unknown:
            NSLog("This region state was unknown!");
        }
    }
}

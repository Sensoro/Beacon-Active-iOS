//
//  SENLocationManager.swift
//  BeaconActive-Swift
//
//  Created by David Yang on 15/4/3.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

import UIKit
import CoreLocation

class SENLocationManager: NSObject, CLLocationManagerDelegate {

    static let sharedInstance = SENLocationManager();

    let locationManager = CLLocationManager();
    var started = false;
    var monitorRegion : CLBeaconRegion!;

    fileprivate override init(){
        
        super.init();
        if UIDevice.current.systemVersion.compare("8.0", options: .numeric, range: nil, locale: nil) != .orderedAscending {
            locationManager.requestAlwaysAuthorization();
        }
        locationManager.delegate = self;
        
        monitorRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "46D06053-9FAD-483B-B704-E576735CE1A3")!,
            identifier: "SensoroBeaconActiveTest");
        
//        monitorRegion.notifyOnEntry = true;
//        monitorRegion.notifyOnExit = true;
    }
    
    func startMonitor( relaunch : Bool ){
        if relaunch == false {
            locationManager.startMonitoring(for: monitorRegion);
            locationManager.startRangingBeacons(in: monitorRegion);
            NSLog("Start monitor region!");
        }else{
//            locationManager.startRangingBeacons(in: monitorRegion);
            NSLog("During the relauch app, don't restart monitor region!");
        }
        started = true;
    }
    
    func stopMonitor(){
        locationManager.stopMonitoring(for: monitorRegion);
        started = false;
        NSLog("Stop monitor region!");
    }
    
    func sendNotification(notify : String){
        let notification = UILocalNotification()
        notification.alertBody = notify
        
//        notification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
        switch state {
        case .inside:
            let now = Date();
            let formatter = DateFormatter();
            formatter.dateFormat = "YYYY/MM/dd HH:mm:ss";
            sendNotification(notify: "Enter region at \(formatter.string(from: now))");
            NSLog("Enter region at \(formatter.string(from: now))");
        case .outside:
            let now = Date();
            let formatter = DateFormatter();
            formatter.dateFormat = "YYYY/MM/dd HH:mm:ss";
            sendNotification(notify: "Exit  region at \(formatter.string(from: now))");
            NSLog("Exit  region at \(formatter.string(from: now))");
        case .unknown:
            NSLog("This region state was unknown!");
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(#function);
        for beacon in beacons{
            print("beacon: \(beacon.description)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("did Fail With Error \(error.localizedDescription)");
    }
}

//
//  SENLocationManager.swift
//  BeaconActive-Swift
//
//  Created by David Yang on 15/4/3.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

import UIKit
import CoreLocation

private let _sharedInstance = SENLocationManager();

class SENLocationManager: NSObject, CLLocationManagerDelegate {

    class var sharedInstance : SENLocationManager {
        return _sharedInstance;
    }

    let locationManager = CLLocationManager();
    var started = false;
    var monitorRegion : CLBeaconRegion!;

    private override init(){
        
        super.init();
        if UIDevice.currentDevice().systemVersion.compare("8.0", options: .NumericSearch, range: nil, locale: nil) != .OrderedAscending {
            locationManager.requestAlwaysAuthorization();
        }
        locationManager.delegate = self;
        
        monitorRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "46D06053-9FAD-483B-B704-E576735CE1A3"),
            identifier: "SensoroBeaconActiveTest");
        
//        monitorRegion.notifyOnEntry = true;
//        monitorRegion.notifyOnExit = true;
    }
    
    func startMonitor( relaunch : Bool ){
        if relaunch == false {
            locationManager.startMonitoringForRegion(monitorRegion);
            NSLog("Start monitor region!");
        }else{
            NSLog("During the relauch app, don't restart monitor region!");
        }
        started = true;
    }
    
    func stopMonitor(){
        locationManager.stopMonitoringForRegion(monitorRegion);
        started = false;
        NSLog("Stop monitor region!");
    }
    
    func sendNotification(notify : String){
        var notification = UILocalNotification()
        notification.alertBody = notify
        
//        notification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
        
        switch state {
        case .Inside:
            let now = NSDate();
            let formatter = NSDateFormatter();
            formatter.dateFormat = "YYYY/MM/dd HH:mm:ss";
            sendNotification("Enter region at \(formatter.stringFromDate(now))");
            NSLog("Enter region at \(formatter.stringFromDate(now))");
        case .Outside:
            let now = NSDate();
            let formatter = NSDateFormatter();
            formatter.dateFormat = "YYYY/MM/dd HH:mm:ss";
            sendNotification("Exit  region at \(formatter.stringFromDate(now))");
            NSLog("Exit  region at \(formatter.stringFromDate(now))");
        case .Unknown:
            NSLog("This region state was unknown!");
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog("did Fail With Error %@", error);
    }
}

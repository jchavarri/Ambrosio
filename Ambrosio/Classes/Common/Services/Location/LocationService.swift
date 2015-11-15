//
//  LocationService.swift
//  Ambrosio
//
//  Created by Javi on 15/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var beaconRegion: CLBeaconRegion?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        let regionUUID = NSUUID.init(UUIDString: "00000000-0000-0000-0000-000000000000")
        if let regionUUID = regionUUID {
            beaconRegion = CLBeaconRegion.init(proximityUUID: regionUUID, identifier: "Ambrosio")
            if let beaconRegion = beaconRegion {
                beaconRegion.notifyEntryStateOnDisplay = true
                beaconRegion.notifyOnEntry = true
                beaconRegion.notifyOnExit = true
                locationManager.startMonitoringForRegion(beaconRegion)
                locationManager.startRangingBeaconsInRegion(beaconRegion)
            }
        }
        
        //notifications
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
    }

    @objc func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        print("Failed monitoring region: \(error.description)")
    }
    
    @objc func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location manager failed: \(error.description)")
    }
    
    @objc func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Location manager entered region")
        let notification = UILocalNotification()
        notification.alertBody = "Are you forgetting something?"
        notification.soundName = "Default"
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    @objc func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Location manager exited region")
        let notification = UILocalNotification()
        notification.alertBody = "Are you forgetting something?"
        notification.soundName = "Default"
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
}
//
//  LocationService.swift
//  Ambrosio
//
//  Created by Javi on 15/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService {
    let locationManager = CLLocationManager()
    var beaconRegion: CLBeaconRegion?
    
    func startRangingWithDelegate(delegate: CLLocationManagerDelegate) {
        locationManager.delegate = delegate
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
        
    }
}

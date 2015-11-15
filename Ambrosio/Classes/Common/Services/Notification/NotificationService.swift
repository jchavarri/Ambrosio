//
//  NotificationService.swift
//  Ambrosio
//
//  Created by Javi on 15/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class NotificationService: NSObject, CLLocationManagerDelegate{
    
    var apiService: APIService?

    override init() {
        //notifications
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    private func showNotificationForTasksWith(alarm:AlarmStatus, body: String) {
        apiService?.getTasks({ (data) -> Void in
            var notificationText = body
            var foundTasks = false
            for task in data {
                if let taskName = task.name {
                    if task.alarm == alarm {
                        foundTasks = true
                        notificationText += "- \(taskName)\n"
                    }
                }
            }
            if foundTasks {
                //Remove trailing break line character
                notificationText = notificationText.substringToIndex(notificationText.endIndex.predecessor())
                let notification = UILocalNotification()
                notification.alertBody = notificationText
                notification.soundName = "Default"
                UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            }
            }, failure: { (error) -> Void in
                print(error)
        })
    }

    @objc func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Location manager entered region")
        showNotificationForTasksWith(AlarmStatus.WhenArriving, body: "Welcome back! Don't forget to:\n")
    }
    
    @objc func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Location manager exited region")
        showNotificationForTasksWith(AlarmStatus.WhenLeaving, body: "Bye bye! Don't forget to:\n")
    }
}
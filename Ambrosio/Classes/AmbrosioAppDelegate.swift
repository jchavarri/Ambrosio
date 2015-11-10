//
//  AmbrosioAppDelegate.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import UIKit

@UIApplicationMain
class AmbrosioAppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var dependencies: AmbrosioAppDependencies?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // initialize dependencies
        self.dependencies = AmbrosioAppDependencies.initWithWindow(window!)
        
        // adding RootViewController
        self.dependencies?.installRootViewControllerIntoWindow(window!)
        
        return true
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        if let dependencies = self.dependencies {
            return dependencies.handleOpenURL(url)
        }
        return false
    }
    
}

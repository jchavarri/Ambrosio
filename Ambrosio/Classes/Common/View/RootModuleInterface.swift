//
//  RootModuleDelegate.swift
//  Ambrosio
//
//  Created by Javi on 09/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol RootModuleInterface {
    // Global events (app level) that are triggered by user actions on the device (for example, opening a link in Mobile Safari)
    func handleOpenURL(url:NSURL) -> Bool
}

protocol RootModuleDelegate {
    func userDidAllowApp()
}
//
//  RootModuleDelegate.swift
//  Ambrosio
//
//  Created by Javi on 09/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol RootModuleInterface {
    func allowAccessWithToken(code: String)
}

protocol RootModuleDelegate {
    func rootModuleDidAllowAccess(code: String)
}
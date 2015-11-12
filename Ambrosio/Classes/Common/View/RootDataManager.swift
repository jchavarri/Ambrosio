//
//  RootDataManager.swift
//  Ambrosio
//
//  Created by Javi on 11/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

class RootDataManager: NSObject
{
    var authStore : AuthStoreProtocol?
    
    func setAuthToken(authToken: String, authTokenExpTime: NSTimeInterval) {
        authStore?.setAuthToken(authToken, authTokenExpTime: authTokenExpTime)
    }
}
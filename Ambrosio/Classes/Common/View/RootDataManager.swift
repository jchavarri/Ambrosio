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
    
    func setAccessToken(accessToken: String, accessTokenExpTime: NSTimeInterval) {
        authStore?.setAccessToken(accessToken, accessTokenExpTime: accessTokenExpTime)
    }
}
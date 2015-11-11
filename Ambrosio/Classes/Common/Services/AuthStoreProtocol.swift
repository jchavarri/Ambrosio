//
//  AccountManagerProtocol.swift
//  Ambrosio
//
//  Created by Javi on 09/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol AuthStoreProtocol {
    
    func getValidAccessToken() -> String?
    func getValidSessionToken() -> String?
    
    func cleanAccount() -> Bool
    
    func setAccessToken(accessToken: String, accessTokenExpTime: NSTimeInterval) -> Bool
    func setSessionToken(sessionToken: String, sessionTokenExpTime: NSTimeInterval) -> Bool
}
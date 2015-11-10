//
//  AccountManagerProtocol.swift
//  Ambrosio
//
//  Created by Javi on 09/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol AuthServiceProtocol
{
    
    static func hasValidAccessToken() -> String?
    static func hasValidSessionToken() -> String?
    
    static func cleanAccount()
    
    static func setAccessToken(accessToken: String, accessTokenExpDate: NSDate)
    static func setSessionToken(sessionToken: String, sessionTokenExpDate: NSDate)
}
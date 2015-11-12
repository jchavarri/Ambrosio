//
//  AuthDataManagerProtocol.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol AuthDataManagerProtocol {

    func getValidAuthToken() -> String?
    func getValidAccessToken() -> String?
    
    func cleanAccount() -> Bool
    
    func setAuthToken(authToken: String, authTokenExpTime: NSTimeInterval) -> Bool
    func setAccessToken(accessToken: String, accessTokenExpTime: NSTimeInterval) -> Bool

}
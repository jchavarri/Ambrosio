//
//  AuthStoreProtocol.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol AuthStoreProtocol {

    func getValidAuthToken() -> String?
    func getValidAccessToken() -> String?
    func getRefreshToken() -> String?
    
    func cleanAccount() -> Bool
    
    func setAuthToken(authToken: String, authTokenExpTime: NSTimeInterval) -> Bool
    func setAccessToken(accessToken: String, accessTokenExpTime: NSTimeInterval, refreshToken: String) -> Bool

}
//
//  AuthServiceProtocol.swift
//  Ambrosio
//
//  Created by Javi on 09/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

//AuthService is a facade for AuthStore and AuthDataManager

protocol AuthServiceProtocol {
    
    // Store
    func hasAccessToken() -> Bool
    func getAccessToken() -> String?
    func hasAuthToken() -> Bool
    func setAuthToken(authToken: String, authTokenExpTime: NSTimeInterval) -> Bool;

    // Data manager
    func postAuthToken(success: () -> Void, failure: (error: NSError) -> Void)
    func getAuthorizationURL() -> NSURL?
    
}
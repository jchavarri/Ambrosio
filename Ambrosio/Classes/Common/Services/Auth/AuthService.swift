//
//  AuthService.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

class AuthService: AuthServiceProtocol {

    var dataManager: AuthDataManagerProtocol?
    var store: AuthStoreProtocol?
    
    // Store
    
    func hasAccessToken() -> Bool {
        if let _ = store?.getValidAccessToken() {
            return true
        }
        else {
            return false
        }
    }
    
    func getAccessToken() -> String? {
        return store?.getValidAccessToken()
    }
    
    func hasAuthToken() -> Bool {
        if let _ = store?.getValidAuthToken() {
            return true
        }
        else {
            return false
        }
    }
    
    func setAuthToken(authToken: String, authTokenExpTime: NSTimeInterval) -> Bool {
        if let store = store {
            return store.setAuthToken(authToken, authTokenExpTime: authTokenExpTime)
        }
        else {
            return false
        }
    }

    
    // Data manager
    
    func getAuthorizationURL() -> NSURL? {
        return dataManager?.getAuthorizationURL()
    }

    func postAuthToken(success: () -> Void, failure: (error: NSError) -> Void) {
        dataManager?.postAuthToken( {(data) -> Void in
            if let accessToken = data["access_token"].string, refreshToken = data["refresh_token"].string {
                let expirationDate = data["expires_in"].double ?? 7200
                // Save to keychain
                self.store?.setAccessToken(accessToken, accessTokenExpTime: expirationDate, refreshToken: refreshToken)
                success()
            }
            else {
                failure(error: NSError(domain: NSURLErrorDomain, code: 0, userInfo: [:]))
            }
            }, failure: failure)
    }
    
}
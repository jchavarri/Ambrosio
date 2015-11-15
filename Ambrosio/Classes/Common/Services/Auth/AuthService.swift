//
//  AuthService.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import SwiftyJSON

class AuthService: AuthServiceProtocol {

    var dataManager: AuthDataManagerProtocol?
    var store: AuthStoreProtocol?
    
    // Private helpers
    
    private func saveAccessToken(data: JSON) -> Bool {
        if let accessToken = data["access_token"].string, refreshToken = data["refresh_token"].string {
            // Save to keychain
            self.store?.setAccessToken(accessToken, refreshToken: refreshToken)
            return true
        }
        else {
            return false
        }
    }
    
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
            if self.saveAccessToken(data) {
                success()
            }
            else {
                failure(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorUserAuthenticationRequired, userInfo: [:]))
            }
            }, failure: failure)
    }
    
    func postRefreshToken(success: () -> Void, failure: (error: NSError) -> Void) {
        dataManager?.postRefreshToken( {(data) -> Void in
            if self.saveAccessToken(data) {
                success()
            }
            else {
                failure(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorUserAuthenticationRequired, userInfo: [:]))
            }
            }, failure: failure)
    }
    
}
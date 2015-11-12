//
//  AuthService.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

class AuthService: AuthServiceProtocol {

    let oAuthURL = "https://redbooth.com/oauth2/"
    var dataManager: AuthDataManager?

    func isLogged() -> Bool {
        if let _ = dataManager?.getValidAccessToken() {
            return true
        }
        else {
            return false
        }
    }
    func hasAuthToken() -> Bool {
        if let _ = dataManager?.getValidAuthToken() {
            return true
        }
        else {
            return false
        }
    }
    func getAuthorizationURL() -> NSURL? {
        return apiManager?.getAuthorizationURL()
    }

}
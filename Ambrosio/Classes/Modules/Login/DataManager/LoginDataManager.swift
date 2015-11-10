//
//  LoginDataManager.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

class LoginDataManager: NSObject
{
    var authStore : AuthStoreProtocol?
    var apiManager : APIManagerProtocol?

    func isLogged() -> Bool {
        if let _ = authStore?.getValidSessionToken() {
            return true
        }
        else {
            return false
        }
    }
    func hasAccessToken() -> Bool {
        if let _ = authStore?.getValidAccessToken() {
            return true
        }
        else {
            return false
        }
    }
    func getAccessURL() -> NSURL? {
        return apiManager?.getAuthorizationURL()
    }
}

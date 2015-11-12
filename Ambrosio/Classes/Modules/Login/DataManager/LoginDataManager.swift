//
//  LoginDataManager.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation
import SwiftyJSON

class LoginDataManager: NSObject
{
    var authStore : AuthStoreProtocol?
    var apiManager : APIManagerProtocol?

    func isLogged() -> Bool {
        if let _ = authStore?.getValidAccessToken() {
            return true
        }
        else {
            return false
        }
    }
    func hasAuthToken() -> Bool {
        if let _ = authStore?.getValidAuthToken() {
            return true
        }
        else {
            return false
        }
    }
    func getAuthorizationURL() -> NSURL? {
        return apiManager?.getAuthorizationURL()
    }
    func getAccessToken(completion: (error: NSError?) -> ()) {
        apiManager?.postSessionToken({ (data) -> Void in
            data["access_token"]
            completion(error: nil)
            },
            failure: { (error) -> Void in
                completion(error: error)
        })
    }
    func setAccessToken(accessToken: String, accessTokenExpTime: NSTimeInterval) -> Bool {
        if let authStore = self.authStore {
            return authStore.setAccessToken(accessToken, accessTokenExpTime: accessTokenExpTime)
        }
        else {
            return false
        }
    }

}

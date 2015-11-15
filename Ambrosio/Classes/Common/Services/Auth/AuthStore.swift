//
//  RedboothAuthManager.swift
//  Ambrosio
//
//  Created by Javi on 09/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import KeychainAccess

private let AmbrosioDefaultService = NSBundle.mainBundle().infoDictionary![String(kCFBundleIdentifierKey)] as? String ?? "com.ambrosio.DefaulService"

private enum AuthAttribute: String
{
    case AuthToken          = "AuthAttributeAuthToken"
    case AuthTokenExp       = "AuthAttributeAuthTokenExp"
    case AccessToken        = "AuthAttributeAccessToken"
    case RefreshToken       = "AuthAttributeRefreshToken"
}

//These are needed to store the data in separate keychain containers
private struct UserAccount {
    private static let AuthAccountKey = "Redbooth_Auth"
    private static let AccessAccountKey = "Redbooth_Access"
}

class AuthStore: AuthStoreProtocol
{
    //MARK: - Private
    private var authToken: String?
    private var authTokenExp: NSDate?
    private var accessToken: String?
    private var refreshToken: String?
    
    init() {
        let keychain = Keychain(service: AmbrosioDefaultService)
        authToken = keychain[AuthAttribute.AuthToken.rawValue]
        if let expTimeString = keychain[AuthAttribute.AuthTokenExp.rawValue] {
            if let expTimeDouble = Double(expTimeString) {
                authTokenExp = NSDate(timeIntervalSince1970:expTimeDouble)
            }
        }
        accessToken = keychain[AuthAttribute.AccessToken.rawValue]
        refreshToken = keychain[AuthAttribute.RefreshToken.rawValue]
    }
    
    //MARK: - AuthServiceProtocol
    
    /**
    Returns a valid auth token if there's any
    
    :returns: The auth token if the app has a valid one, .None ioc
    */
    func getValidAuthToken() -> String? {
        if let authToken = self.authToken {
            if let expiration = self.authTokenExp {
                if !expiration.timeIntervalSinceNow.isSignMinus {
                    return authToken
                }
            }
        }
        return .None
    }
    
    /**
     Returns a valid access token if there's any
     
     :returns: Access token if the app has a valid access token, .None ioc
     */
    func getValidAccessToken() -> String? {
        return self.accessToken
    }
    
    /**
     Returns a valid refresh token if there's any
     
     :returns: Refresh token if the app has a valid refresh token, .None ioc
     */
    func getRefreshToken() -> String? {
        return self.refreshToken
    }
    
    /**
     Persist an auth token in the keychain
     
     :param: authToken              The auth token string
     :param: authTokenExpDate       The expiration time from now, in seconds
     :returns: true if the data was saved correctly, false ioc
     */
    func setAuthToken(authToken: String, authTokenExpTime: NSTimeInterval) -> Bool {
        let expirationDate = NSDate().dateByAddingTimeInterval(authTokenExpTime)
        let keychain = Keychain(service: AmbrosioDefaultService)
        keychain[AuthAttribute.AuthToken.rawValue] = authToken
        keychain[AuthAttribute.AuthTokenExp.rawValue] = String(expirationDate.timeIntervalSince1970)
        self.authToken = authToken
        self.authTokenExp = expirationDate
        return true
    }
    /**
     Persist an access token in the keychain
     
     :param: accessToken              The access token string
     :param: refreshToken             The refresh token string
     :returns: true if the data was saved correctly, false ioc
     */
    func setAccessToken(accessToken: String, refreshToken: String) -> Bool {
        let keychain = Keychain(service: AmbrosioDefaultService)
        keychain[AuthAttribute.AccessToken.rawValue] = accessToken
        keychain[AuthAttribute.RefreshToken.rawValue] = refreshToken
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        return true
    }
    
    /**
     Removes the persisted auth data
     :returns: true if the data was cleaned correctly, false ioc
     */
    func cleanAccount() -> Bool {
        authToken = .None
        authTokenExp = .None
        accessToken = .None
        refreshToken = .None
        let keychain = Keychain(service: AmbrosioDefaultService)
        keychain[AuthAttribute.AuthToken.rawValue] = nil
        keychain[AuthAttribute.AuthTokenExp.rawValue] = nil
        keychain[AuthAttribute.AccessToken.rawValue] = nil
        keychain[AuthAttribute.RefreshToken.rawValue] = nil
        return true
    }
    
    
    
}

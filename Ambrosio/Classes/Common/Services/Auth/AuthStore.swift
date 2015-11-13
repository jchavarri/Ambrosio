//
//  RedboothAuthManager.swift
//  Ambrosio
//
//  Created by Javi on 09/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import Locksmith

private enum AuthAttribute: String
{
    case AuthToken          = "AuthAttributeAuthToken"
    case AuthTokenExp       = "AuthAttributeAuthTokenExp"
    case AccessToken        = "AuthAttributeAccessToken"
    case AccessTokenExp     = "AuthAttributeAccessTokenExp"
    case RefreshToken       = "AuthAttributeRefreshToken"
}

class AuthStore: AuthStoreProtocol
{
    //MARK: - Private
    private var authToken: String?
    private var authTokenExp: NSDate?
    private var accessToken: String?
    private var accessTokenExp: NSDate?
    private var refreshToken: String?
    
    //These are needed to store the data in separate keychain containers
    private struct UserAccount {
        private static let AuthAccountKey = "Redbooth_Auth"
        private static let AccessAccountKey = "Redbooth_Access"
    }

    init() {
        if let authAccountDict = Locksmith.loadDataForUserAccount(UserAccount.AuthAccountKey) {
            authToken = authAccountDict[AuthAttribute.AuthToken.rawValue] as? String
            authTokenExp = authAccountDict[AuthAttribute.AuthTokenExp.rawValue] as? NSDate
        }
        if let authAccountDict = Locksmith.loadDataForUserAccount(UserAccount.AccessAccountKey) {
            accessToken = authAccountDict[AuthAttribute.AccessToken.rawValue] as? String
            accessTokenExp = authAccountDict[AuthAttribute.AccessTokenExp.rawValue] as? NSDate
            refreshToken = authAccountDict[AuthAttribute.RefreshToken.rawValue] as? String
        }
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
     
     :returns: Auth token if the app has a valid access token, .None ioc
     */
    func getValidAccessToken() -> String? {
        var returnValue:String? = .None
        if let authAccountDict = Locksmith.loadDataForUserAccount(UserAccount.AccessAccountKey) {
            if let accessToken = authAccountDict[AuthAttribute.AccessToken.rawValue] as? String
            {
                if let expiration = authAccountDict[AuthAttribute.AccessTokenExp.rawValue] as? NSDate {
                    if expiration.timeIntervalSinceNow.isSignMinus {
                        returnValue = accessToken
                    }
                }
            }
        }
        return returnValue
    }
    
    /**
     Persist an auth token in the keychain
     
     :param: authToken              The auth token string
     :param: authTokenExpDate       The expiration time from now, in seconds
     :returns: true if the data was saved correctly, false ioc
     */
    func setAuthToken(authToken: String, authTokenExpTime: NSTimeInterval) -> Bool {
        do {
            let expirationDate = NSDate().dateByAddingTimeInterval(authTokenExpTime)
            if let _ = self.authToken {
                try Locksmith.deleteDataForUserAccount(UserAccount.AuthAccountKey)
                self.authToken = nil
                self.authTokenExp = nil
            }
            try Locksmith.saveData([
                    AuthAttribute.AuthToken.rawValue: authToken,
                    AuthAttribute.AuthTokenExp.rawValue: expirationDate
                ],
                forUserAccount: UserAccount.AuthAccountKey)
            self.authToken = authToken
            self.authTokenExp = expirationDate
            return true
        } catch {
            return false
        }
    }
    /**
     Persist an access token in the keychain
     
     :param: accessToken              The access token string
     :param: accessTokenExpTime       The expiration time from now, in seconds
     :param: refreshToken             The refresh token string
     :returns: true if the data was saved correctly, false ioc
     */
    func setAccessToken(accessToken: String, accessTokenExpTime: NSTimeInterval, refreshToken: String) -> Bool {
        do {
            let expirationDate = NSDate().dateByAddingTimeInterval(accessTokenExpTime)
            if let _ = self.accessToken {
                try Locksmith.deleteDataForUserAccount(UserAccount.AuthAccountKey)
                self.accessToken = nil
                self.accessTokenExp = nil
                self.refreshToken = nil
            }
            try Locksmith.saveData([
                AuthAttribute.AccessToken.rawValue: accessToken,
                AuthAttribute.AccessTokenExp.rawValue: expirationDate,
                AuthAttribute.RefreshToken.rawValue: refreshToken
                ],
                forUserAccount: UserAccount.AccessAccountKey)
            self.accessToken = accessToken
            self.accessTokenExp = expirationDate
            self.refreshToken = refreshToken
            return true
        } catch {
            return false
        }
    }
    
    /**
     Removes the persisted auth data
     :returns: true if the data was cleaned correctly, false ioc
     */
    func cleanAccount() -> Bool {
        do {
            authToken = .None
            authTokenExp = .None
            accessToken = .None
            accessTokenExp = .None
            refreshToken = .None
            try Locksmith.deleteDataForUserAccount(UserAccount.AuthAccountKey)
            try Locksmith.deleteDataForUserAccount(UserAccount.AccessAccountKey)
            return true
        } catch {
            return false
        }
    }
    
    
    
}

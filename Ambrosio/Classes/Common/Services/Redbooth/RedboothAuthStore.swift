//
//  RedboothAuthManager.swift
//  Ambrosio
//
//  Created by Javi on 09/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import Locksmith

private enum RedboothAuthAttribute: String
{
    case AuthToken        = "RedboothAuthAttributeAuthToken"
    case AuthTokenExp     = "RedboothAuthAttributeAuthTokenExp"
    case AccessToken       = "RedboothAuthAttributeAccessToken"
    case AccessTokenExp    = "RedboothAuthAttributeAccessTokenExp"
}

class RedboothAuthStore: AuthStoreProtocol
{
    //MARK: - Private
    private var authToken: String?
    private var authTokenExp: NSDate?
    private var accessToken: String?
    private var accessTokenExp: NSDate?
    
    //These are needed to store the data in separate keychain containers
    private struct UserAccount {
        private static let AuthAccountKey = "Redbooth_Auth"
        private static let AccessAccountKey = "Redbooth_Access"
    }

    init() {
        if let authAccountDict = Locksmith.loadDataForUserAccount(UserAccount.AuthAccountKey) {
            authToken = authAccountDict[RedboothAuthAttribute.AuthToken.rawValue] as? String
            authTokenExp = authAccountDict[RedboothAuthAttribute.AuthTokenExp.rawValue] as? NSDate
        }
        if let authAccountDict = Locksmith.loadDataForUserAccount(UserAccount.AccessAccountKey) {
            accessToken = authAccountDict[RedboothAuthAttribute.AccessToken.rawValue] as? String
            accessTokenExp = authAccountDict[RedboothAuthAttribute.AccessTokenExp.rawValue] as? NSDate
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
                if expiration.timeIntervalSinceNow.isSignMinus {
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
            if let accessToken = authAccountDict[RedboothAuthAttribute.AccessToken.rawValue] as? String
            {
                if let expiration = authAccountDict[RedboothAuthAttribute.AccessTokenExp.rawValue] as? NSDate {
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
            try Locksmith.saveData([
                    RedboothAuthAttribute.AuthToken.rawValue: authToken,
                    RedboothAuthAttribute.AuthTokenExp.rawValue: expirationDate
                ],
                forUserAccount: UserAccount.AccessAccountKey)
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
     :returns: true if the data was saved correctly, false ioc
     */
    func setAccessToken(accessToken: String, accessTokenExpTime: NSTimeInterval) -> Bool {
        do {
            let expirationDate = NSDate().dateByAddingTimeInterval(accessTokenExpTime)
            try Locksmith.saveData([
                RedboothAuthAttribute.AccessToken.rawValue: accessToken,
                RedboothAuthAttribute.AccessTokenExp.rawValue: expirationDate
                ],
                forUserAccount: UserAccount.AccessAccountKey)
            self.accessToken = accessToken
            self.accessTokenExp = expirationDate
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
            try Locksmith.deleteDataForUserAccount(UserAccount.AuthAccountKey)
            try Locksmith.deleteDataForUserAccount(UserAccount.AccessAccountKey)
            return true
        } catch {
            return false
        }
    }
    
    
}

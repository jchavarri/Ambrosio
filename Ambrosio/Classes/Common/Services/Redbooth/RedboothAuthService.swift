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
    case AccessToken        = "RedboothAuthAttributeAccessToken"
    case AccessTokenExp     = "RedboothAuthAttributeAccessTokenExp"
    case SessionToken       = "RedboothAuthAttributeSessionToken"
    case SessionTokenExp    = "RedboothAuthAttributeSessionExp"
}

class RedboothAuthStore: AuthStoreProtocol
{
    //MARK: - Private
    private var accessToken: String?
    private var accessTokenExp: NSDate?
    private var sessionToken: String?
    private var sessionTokenExp: NSDate?
    
    private struct UserAccount {
        private static let AccessAccountKey = "Redbooth_Access"
        private static let SessionAccountKey = "Redbooth_Session"
    }

    init() {
        if let authAccountDict = Locksmith.loadDataForUserAccount(UserAccount.AccessAccountKey) {
            accessToken = authAccountDict[RedboothAuthAttribute.AccessToken.rawValue] as? String
            accessTokenExp = authAccountDict[RedboothAuthAttribute.AccessTokenExp.rawValue] as? NSDate
            sessionToken = authAccountDict[RedboothAuthAttribute.SessionToken.rawValue] as? String
            sessionTokenExp = authAccountDict[RedboothAuthAttribute.SessionTokenExp.rawValue] as? NSDate
        }
    }
    
    //MARK: - AuthServiceProtocol
    
    /**
    Returns a valid access token is there's any
    
    :returns: Auth token if the app has a valid access token, .None ioc
    */
    func getValidAccessToken() -> String? {
        if let accessToken = self.accessToken {
            if let expiration = self.accessTokenExp {
                if expiration.timeIntervalSinceNow.isSignMinus {
                    return accessToken
                }
            }
        }
        return .None
    }
    
    /**
     Returns a valid session token if there's any
     
     :returns: Auth token if the app has a valid session token, .None ioc
     */
    func getValidSessionToken() -> String? {
        var returnValue:String? = .None
        if let authAccountDict = Locksmith.loadDataForUserAccount(UserAccount.SessionAccountKey) {
            if let sessionToken = authAccountDict[RedboothAuthAttribute.SessionToken.rawValue] as? String
            {
                if let expiration = authAccountDict[RedboothAuthAttribute.SessionTokenExp.rawValue] as? NSDate {
                    if expiration.timeIntervalSinceNow.isSignMinus {
                        returnValue = sessionToken
                    }
                }
            }
        }
        return returnValue
    }
    
    /**
     Persist an auth token in the keychain
     
     :param: accessToken              The auth token string
     :param: accessTokenExpDate       The expiration time from now, in seconds
     */
    func setAccessToken(accessToken: String, accessTokenExpTime: NSTimeInterval) {
        do {
            let expirationDate = NSDate().dateByAddingTimeInterval(accessTokenExpTime)
            try Locksmith.saveData([
                    RedboothAuthAttribute.AccessToken.rawValue: accessToken,
                    RedboothAuthAttribute.AccessTokenExp.rawValue: expirationDate
                ],
                forUserAccount: UserAccount.AccessAccountKey)
            self.accessToken = accessToken
            self.accessTokenExp = expirationDate
        } catch { }
    }
    /**
     Persist a session token in the keychain
     
     :param: sessionToken              The session token string
     :param: sessionTokenExpTime       The expiration time from now, in seconds
     */
    func setSessionToken(sessionToken: String, sessionTokenExpTime: NSTimeInterval) {
        do {
            let expirationDate = NSDate().dateByAddingTimeInterval(sessionTokenExpTime)
            try Locksmith.saveData([
                RedboothAuthAttribute.SessionToken.rawValue: sessionToken,
                RedboothAuthAttribute.SessionTokenExp.rawValue: expirationDate
                ],
                forUserAccount: UserAccount.SessionAccountKey)
            self.sessionToken = sessionToken
            self.sessionTokenExp = expirationDate
        } catch { }
    }
    
    /**
     Removes the persisted account
     */
    func cleanAccount() {
        do {
            accessToken = .None
            accessTokenExp = .None
            sessionToken = .None
            sessionTokenExp = .None
            try Locksmith.deleteDataForUserAccount(UserAccount.AccessAccountKey)
            try Locksmith.deleteDataForUserAccount(UserAccount.SessionAccountKey)
        } catch { }
    }
    
    
}

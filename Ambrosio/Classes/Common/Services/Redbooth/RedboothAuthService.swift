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

class RedboothAuthService: AuthServiceProtocol
{
    //MARK: - AuthServiceProtocol
    
    /**
    Returns true if the app has already been approved and there's a valid auth token
    
    :returns: Auth token if the app has a valid auth token, .None ioc
    */
    class func hasValidAccessToken() -> String? {
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
     Returns true if the app has a valid session token
     
     :returns: Auth token if the app has a valid session token, .None ioc
     */
    class func hasValidSessionToken() -> String? {
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
     :param: accessTokenExpDate       The expiration date
     */
    class func setAccessToken(accessToken: String, accessTokenExpDate: NSDate) {
        do {
            try Locksmith.saveData([
                    RedboothAuthAttribute.AccessToken.rawValue: accessToken,
                    RedboothAuthAttribute.AccessTokenExp.rawValue: accessTokenExpDate
                ],
                forUserAccount: UserAccount.AccessAccountKey)
        } catch { }
    }
    /**
     Persist a session token in the keychain
     
     :param: sessionToken              The session token string
     :param: sessionTokenExpDate       The expiration date
     */
    class func setSessionToken(sessionToken: String, sessionTokenExpDate: NSDate) {
        do {
            try Locksmith.saveData([
                RedboothAuthAttribute.SessionToken.rawValue: sessionToken,
                RedboothAuthAttribute.SessionTokenExp.rawValue: sessionTokenExpDate
                ],
                forUserAccount: UserAccount.SessionAccountKey)
        } catch { }
    }
    
    /**
     Removes the persisted account
     */
    class func cleanAccount() {
        do {
            try Locksmith.deleteDataForUserAccount(UserAccount.AccessAccountKey)
            try Locksmith.deleteDataForUserAccount(UserAccount.SessionAccountKey)
        } catch { }
    }
    
    //MARK: - Private
    
    private struct UserAccount {
        private static let AccessAccountKey = "Redbooth_Access"
        private static let SessionAccountKey = "Redbooth_Session"
    }
    
}

//
//  AuthDataManager.swift
//  Ambrosio
//
//  Created by Javi on 13/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum AuthPath: String
{
    case Authorize      = "authorize"
    case Token          = "token"
}

class AuthDataManager: AuthDataManagerProtocol {
    
    let oAuthURL = "https://redbooth.com/oauth2/"
    var store: AuthStoreProtocol?
    
    private static func encodedRedirectUri() -> String? {
        let redirectUri = Config.redirectUri
        let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        allowedCharacters.removeCharactersInString(":/")
        return redirectUri.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)
    }

    func getAuthorizationURL() -> NSURL? {
        if let encodedRedirectUri = AuthDataManager.encodedRedirectUri() {
            // 'response_type=token' doesn't allow to refresh later, so using code
            let url:String = oAuthURL + AuthPath.Authorize.rawValue + "?client_id=\(Config.clientId)&redirect_uri=\(encodedRedirectUri)&response_type=code"
            return NSURL(string: url)
        }
        return .None
    }
    
    // Helpers
    private func postRequest (url: String, parameters: [String : AnyObject], success: (data: JSON) -> Void, failure: (error: NSError) -> Void)  {
        Alamofire.request(.POST, url, parameters: parameters)
            .responseJSON { response in
                guard response.result.error == nil else {
                    failure (error: response.result.error!)
                    return
                }
                // If there's no error, value is not nil
                success(data: JSON(response.result.value!))
            }
    }
    
    // Auth
    
    func postAuthToken(success: (data: JSON) -> Void, failure: (error: NSError) -> Void)  {
        if let encodedRedirectUri = AuthDataManager.encodedRedirectUri(), accessToken = store?.getValidAuthToken() {
            let parameters = [
                "client_id": Config.clientId,
                "client_secret": Config.clientSecret,
                "code": accessToken,
                "grant_type": "authorization_code",
                "redirect_uri": encodedRedirectUri
            ]
            var url = oAuthURL + AuthPath.Token.rawValue + "?"
            for (parameter, value) in parameters {
                url += parameter + "=" + value + "&"
            }
            postRequest(url, parameters: parameters, success: success, failure: failure)
        }
        else {
            failure(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: .None))
        }
    }
    
    func postRefreshToken(success: (data: JSON) -> Void, failure: (error: NSError) -> Void)  {
        if let refreshToken = store?.getRefreshToken() {
            let parameters = [
                "client_id": Config.clientId,
                "client_secret": Config.clientSecret,
                "refresh_token": refreshToken,
                "grant_type": "refresh_token"
            ]
            var url = oAuthURL + AuthPath.Token.rawValue + "?"
            for (parameter, value) in parameters {
                url += parameter + "=" + value + "&"
            }
            postRequest(url, parameters: parameters, success: success, failure: failure)
            
        }
        else {
            failure(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: .None))
        }
    }
    

}
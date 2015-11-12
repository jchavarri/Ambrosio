//
//  RedboothAPIManager.swift
//  Ambrosio
//
//  Created by Javi on 10/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import Alamofire

enum AuthPath: String
{
    case Authorize      = "authorize"
    case Token          = "token"
}

enum Path: String
{
    case Me             = "me"
}

class RedboothAPIManager: APIManagerProtocol {
    
    typealias NetworkSuccessHandler = (data: AnyObject?) -> Void
    typealias NetworkFailureHandler = (error: NSError) -> Void
    
    let apiURL = "https://redbooth.com/api/3/"
    let oAuthURL = "https://redbooth.com/oauth2/"
    
    var authStore: RedboothAuthStore?
    
    init() { }
    
    private static func encodedRedirectUri() -> String? {
        let redirectUri = Config.redirectUri
        let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        allowedCharacters.removeCharactersInString(":/")
        return redirectUri.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)
    }
    
    func getAuthorizationURL() -> NSURL? {
        if let encodedRedirectUri = RedboothAPIManager.encodedRedirectUri() {
            // 'response_type=token' doesn't allow to refresh later, so using code
            let url:String = oAuthURL + AuthPath.Authorize.rawValue + "?client_id=\(Config.clientId)&redirect_uri=\(encodedRedirectUri)&response_type=code"
            return NSURL(string: url)
        }
        return .None
    }
    
    func requestJSON(path: String, parameters: [String : AnyObject]?, success: NetworkSuccessHandler, failure: NetworkFailureHandler) {
        let url = apiURL + path
        Alamofire.request(.GET, url, parameters: parameters)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    failure (error: response.result.error!)
                    return
                }
                
                if let value: AnyObject = response.result.value {
                    success(data: value)
                }
        }
    }
    
    func postSessionToken(success: NetworkSuccessHandler, failure: NetworkFailureHandler) {
        if let encodedRedirectUri = RedboothAPIManager.encodedRedirectUri(), accessToken = authStore?.getValidAuthToken() {
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
            Alamofire.request(.POST, url, parameters: [:])
                .responseJSON { response in
                    guard response.result.error == nil else {
                        print(response.result.error!)
                        failure (error: response.result.error!)
                        return
                    }
                    
                    if let value: AnyObject = response.result.value {
                        success(data: value)
                    }
            }
        }
        else {
            failure(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: .None))
        }
    }
    
    func getUserInfo(success: NetworkSuccessHandler, failure: NetworkFailureHandler) {
        requestJSON(Path.Me.rawValue, parameters: [String: String](), success: { (data) -> () in
            print(data)
            success(data: data)
        }) { (error) -> () in
            print(error)
            failure(error: error)
        }
    }
    
}

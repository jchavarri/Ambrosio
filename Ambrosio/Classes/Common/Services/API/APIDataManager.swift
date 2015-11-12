//
//  RedboothAPIManager.swift
//  Ambrosio
//
//  Created by Javi on 10/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Path: String
{
    case Me             = "me"
    case Tasks          = "tasks"
}

class APIDataManager {
    
    typealias NetworkSuccessHandler = (data: JSON) -> Void
    typealias NetworkFailureHandler = (error: NSError) -> Void
    
    let apiURL = "https://redbooth.com/api/3/"
    
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
    
    //Generic API Helpers
    
    func requestJSON(method: Alamofire.Method, path: String, parameters: [String : AnyObject]?, success: NetworkSuccessHandler, failure: NetworkFailureHandler) {
        let url = apiURL + path
        Alamofire.request(method, url, parameters: parameters)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    failure (error: response.result.error!)
                    return
                }
                // If there's no error, value is not nil
                success(data: JSON(response.result.value!))
        }
    }
    
    func getJSON(path: String, parameters: [String : AnyObject]?, success: NetworkSuccessHandler, failure: NetworkFailureHandler) {
        requestJSON(.GET, path: path, parameters: parameters, success: success, failure: failure)
    }
    
    func postJSON(path: String, parameters: [String : AnyObject]?, success: NetworkSuccessHandler, failure: NetworkFailureHandler) {
        requestJSON(.GET, path: path, parameters: parameters, success: success, failure: failure)
    }
    
    // Auth
    
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
            postJSON(url, parameters: parameters, success: success, failure: failure)
        }
        else {
            failure(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: .None))
        }
    }
    
    // User
    
    func getUserInfo(success: NetworkSuccessHandler, failure: NetworkFailureHandler) -> Void {
        getJSON(Path.Me.rawValue, parameters: [String: String](), success: success, failure: failure)
    }
    
    // Tasks
    
    func getTasks(success: NetworkSuccessHandler, failure: NetworkFailureHandler) {
        getJSON(Path.Tasks.rawValue, parameters: [String: String](), success: success, failure: failure)
    }
    
}

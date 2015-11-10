//
//  RedboothAPIManager.swift
//  Ambrosio
//
//  Created by Javi on 10/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import Alamofire

enum Path: String
{
    case Me             = "me"
}

class RedboothAPIManager: APIManagerProtocol {
    
    typealias NetworkSuccessHandler = (data: AnyObject?) -> Void
    typealias NetworkFailureHandler = (error: NSError) -> Void
    
    let apiURL = "https://redbooth.com/api/3/"
    let oAuthURL = "https://redbooth.com/oauth2/authorize/"
    
    init() { }
    
    func requestJSON(path: String, parameters: [String : AnyObject]?, success: NetworkSuccessHandler, failure: NetworkFailureHandler) {
        let url = apiURL + path
        Alamofire.request(.GET, url, parameters: parameters)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print(response.result.error!)
                    failure (error: response.result.error!)
                    return
                }
                
                if let value: AnyObject = response.result.value {
                    success(data: value)
                }
        }
    }

    func getAuthorizationURL() -> NSURL? {
        let redirectUri = Config.redirectUri
        let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        allowedCharacters.removeCharactersInString(":/")
        if let encodedRedirectUri = redirectUri.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) {
            let url:String = oAuthURL + "client_id=\(Config.apiUsername)&redirect_uri=\(encodedRedirectUri)&response_type=access_token"
            return NSURL(string: url)
        }
        return .None
    }
    
    func getUserInfo() {
        requestJSON(Path.Me.rawValue, parameters: [String: String](), success: { (data) -> () in
                print(data)
            }) { (error) -> () in
                print(error)
        }
    }
    
}

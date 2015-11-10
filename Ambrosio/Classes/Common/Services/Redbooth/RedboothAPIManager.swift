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
    
    let apiURL = "https://redbooth.com/api/3/"
    let oAuthURL = "https://redbooth.com/oauth2/authorize/"
    
    init() { }
    
    func requestJSON(path: String, parameters: [String : AnyObject]?, success: (data :AnyObject) -> (), failure: (error :NSError) -> ()) {
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

    func getAuthorizationUrlWithRedirectURI( redirectURI: String) -> String {
        return oAuthURL + "client_id=\(Config.apiUsername)&redirect_uri=\(redirectURI)&response_type=code"
    }
    
    func getUserInfo() {
        requestJSON(Path.Me.rawValue, parameters: [String: String](), success: { (data) -> () in
                print(data)
            }) { (error) -> () in
                print(error)
        }
    }
    
}

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
    
    let apiURL = "https://redbooth.com/api/3/"
    
    var authService: AuthServiceProtocol?
    
    init() { }
    
    //Generic Network helpers
    //TODO: This should go into a shared manager
    
    func requestJSON(method: Alamofire.Method, path: String, parameters: [String : AnyObject]?, success: (data: JSON) -> Void, failure: (error: NSError) -> Void) {
        
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
    
    func getJSON(path: String, parameters: [String : AnyObject]?, success: (data: JSON) -> Void, failure: (error: NSError) -> Void) {
        requestJSON(.GET, path: path, parameters: parameters, success: success, failure: failure)
    }
    
    // User
    
    func getUserInfo(success: (data: JSON) -> Void, failure: (error: NSError) -> Void) -> Void {
        getJSON(Path.Me.rawValue, parameters: [String: String](), success: success, failure: failure)
    }
    
    // Tasks
    
    func getTasks(success: (data: JSON) -> Void, failure: (error: NSError) -> Void) {
        getJSON(Path.Tasks.rawValue, parameters: [String: String](), success: success, failure: failure)
    }
    
}

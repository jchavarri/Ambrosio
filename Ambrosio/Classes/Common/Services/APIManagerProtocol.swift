//
//  APIProtocol.swift
//  Ambrosio
//
//  Created by Javi on 10/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol APIManagerProtocol {
    
    func getAuthorizationURL() -> NSURL?
    func requestJSON(path: String, parameters: [String : AnyObject]?, success: (data: AnyObject?) -> Void, failure: (error: NSError) -> Void)
    
    func postSessionToken(success: (data: AnyObject?) -> Void, failure: (error: NSError) -> Void)
    func getUserInfo(success: (data: AnyObject?) -> Void, failure: (error: NSError) -> Void)

}

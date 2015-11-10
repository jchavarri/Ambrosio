//
//  APIProtocol.swift
//  Ambrosio
//
//  Created by Javi on 10/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

public protocol APIManagerProtocol {
    
    func requestJSON(url: String, parameters: [String : AnyObject]?, success: (data :AnyObject) -> (), failure: (error :NSError) -> ())
    
}

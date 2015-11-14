//
//  AuthDataManagerProtocol.swift
//  Ambrosio
//
//  Created by Javi on 13/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol AuthDataManagerProtocol {
    
    func getAuthorizationURL() -> NSURL?
    
    func postAuthToken(success: (data: JSON) -> Void, failure: (error: NSError) -> Void)
    func postRefreshToken(success: (data: JSON) -> Void, failure: (error: NSError) -> Void)
    
}
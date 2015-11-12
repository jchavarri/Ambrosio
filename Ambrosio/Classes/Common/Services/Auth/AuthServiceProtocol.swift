//
//  AuthServiceProtocol.swift
//  Ambrosio
//
//  Created by Javi on 09/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol AuthServiceProtocol {
    
    func getAuthorizationURL() -> NSURL?

    func postAuthToken(success: (data: AccessTokenModel) -> Void, failure: (error: NSError) -> Void)
    
}
//
//  AccessTokenModel.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

public struct AccessTokenModel {
    
    public var accessToken: String
    public var refreshToken: String
    public var expirationDate: NSDate

    init(accessToken: String, refreshToken: String, expirationDate: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expirationDate = expirationDate
    }

}
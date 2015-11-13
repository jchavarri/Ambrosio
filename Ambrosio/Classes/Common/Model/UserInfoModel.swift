//
//  UserInfoModel.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

public struct UserInfoModel {
    
    public var id: String
    public var userName: String?
    public var email: String?
    public var firstName: String?
    public var lastName: String?
    
    init(id: String, userName: String?, email: String?, firstName: String?, lastName: String?) {
        self.id = id
        self.userName = userName
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }

}
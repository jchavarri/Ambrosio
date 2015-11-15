//
//  ProjectModel.swift
//  Ambrosio
//
//  Created by Javi on 15/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

public struct ProjectModel {
    
    public var id: Int
    public var name: String?
    
    init(id: Int, name: String?) {
        self.id = id
        self.name = name
    }
    
}
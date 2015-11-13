//
//  TaskModel.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

public struct TaskModel {
    
    public var id: String
    public var name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}
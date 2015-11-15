//
//  TaskModel.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

public enum AlarmStatus
{
    case Disabled
    case WhenLeaving
    case WhenArriving
}

public struct TaskModel {
    
    public var id: Int
    public var name: String?
    public var description: String?
    public var alarm: AlarmStatus

    init(id: Int, name: String?, description: String?, alarm: AlarmStatus?) {
        self.id = id
        self.name = name
        self.description = description
        self.alarm = alarm ?? .Disabled
    }

}
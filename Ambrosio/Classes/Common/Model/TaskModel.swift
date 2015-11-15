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
    public var dueOn: String?
    public var alarm: AlarmStatus
    public var project: ProjectModel

    init(id: Int, name: String?, description: String?, dueOn: String?, alarm: AlarmStatus?, project: ProjectModel) {
        self.id = id
        self.name = name
        self.description = description
        self.dueOn = dueOn
        self.alarm = alarm ?? .Disabled
        self.project = project
    }

}
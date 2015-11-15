//
//  MemoryStore.swift
//  Ambrosio
//
//  Created by Javi on 15/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

public class MemoryStore {
    public var tasks:[TaskModel]
    public var projects:[ProjectModel]
    
    init() {
        tasks = [TaskModel]()
        projects = [ProjectModel]()
    }
    
    public func getProjectWithId(projectId: Int) -> ProjectModel? {
        for project in projects {
            if project.id == projectId {
                return project
            }
        }
        return .None
    }
}
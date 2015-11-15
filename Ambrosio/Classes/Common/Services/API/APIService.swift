//
//  APIService.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIService: APIServiceProtocol {
    
    var dataManager: APIDataManager?
    var descriptionWrapper: APITaskDescriptionWrapper?
    var memoryStore: MemoryStore?
    // User
    
    func getUserInfo(success: (data: UserInfoModel) -> Void, failure: (error: NSError) -> Void) {
        dataManager?.getUserInfo( {(data) -> Void in
                if let userId = data["id"].string {
                    let userInfo = UserInfoModel(
                        id: userId,
                        userName: data["username"].string,
                        email: data["email"].string,
                        firstName: data["first_name"].string,
                        lastName: data["last_name"].string)
                    success(data: userInfo)
            }
            }, failure: failure)
    }
    
    // Tasks
    
    func getTasks(success: (data: [TaskModel]) -> Void, failure: (error: NSError) -> Void) {
        dataManager?.getTasks({ (data) -> Void in
            var tasks = [TaskModel]()
            for taskData in data.arrayValue {
                if let projectId = taskData["project_id"].int,
                    project = self.memoryStore?.getProjectWithId(projectId),
                    taskId = taskData["id"].int {
                        var dueOn:Optional<NSDate> = .None
                        print(taskData["name"].string)
                        var task = TaskModel(
                            id: taskId,
                            name: taskData["name"].string,
                            description: taskData["description"].string,
                            dueOn: taskData["due_on"].string,
                            alarm: .Disabled,
                            project: project)
                        //Unwrap description
                        if let descriptionWrapper = self.descriptionWrapper {
                            task = descriptionWrapper.unwrapTaskDescription(task)
                        }
                        tasks.append(task)
                }
            }
            success(data: tasks)
            }, failure: failure)
    }
    
    // Projects
    
    func getProjects(success: (data: [ProjectModel]) -> Void, failure: (error: NSError) -> Void) {
        dataManager?.getProjects({ (data) -> Void in
            var projects = [ProjectModel]()
            for projectData in data.arrayValue {
                if let projectId = projectData["id"].int {
                    let project = ProjectModel(
                        id: projectId,
                        name: projectData["name"].string)
                    projects.append(project)
                }
            }
            // Update memory store
            self.memoryStore?.projects = projects
            success(data: projects)
            }, failure: failure)
    }
    
    func putTask(task: TaskModel, success: () -> Void, failure: (error: NSError) -> Void) {
        // Append Ambrosio alarm status to the task description
        if let descriptionWrapper = descriptionWrapper {
            let wrappedTask = descriptionWrapper.wrapTaskDescription(task)
            dataManager?.putTask(wrappedTask, success: success, failure: failure)
        }
    }
}
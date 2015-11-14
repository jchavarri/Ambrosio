//
//  APIService.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIService {
    
    var dataManager: APIDataManager?
    
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
                if let taskId = taskData["id"].int {
                    let task = TaskModel(
                        id: taskId,
                        name: taskData["name"].string)
                    tasks.append(task)
                }
            }
            success(data: tasks)
            print(data)
            }, failure: failure)
    }
}
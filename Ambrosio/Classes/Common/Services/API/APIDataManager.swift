//
//  RedboothAPIManager.swift
//  Ambrosio
//
//  Created by Javi on 10/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Path: String
{
    case Me             = "me"
    case Tasks          = "tasks"
    case Projects          = "projects"
}

class APIDataManager {
    
    let apiURL = "https://redbooth.com/api/3/"
    
    private var cachedTasks = Array<(Response<AnyObject, NSError>?)->Void>()
    private var isRefreshing = false
    var authService: AuthServiceProtocol?

    init() { }
    
    //Generic Network helpers
    
    private func requestJSON(method: Alamofire.Method, path: String, parameters: [String : AnyObject]?, success: (data: JSON) -> Void, failure: (error: NSError) -> Void) {
        
        // Store the task just in case it goes wrong
        let cachedTask: (Response<AnyObject, NSError>?)->Void = { response in
            guard response?.result.error == nil else {
                failure (error: response!.result.error!)
                return
            }
            self.requestJSON(method, path: path, parameters: parameters, success: success, failure: failure)
        }
        
        if self.isRefreshing {
            self.cachedTasks.append(cachedTask)
        }
        
        var requestParameters = parameters!
        if let authService = authService, accessToken = authService.getAccessToken() {
            requestParameters["access_token"] = accessToken
        }
        
        let url = apiURL + path
        
        Alamofire.request(method, url, parameters: requestParameters)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    print(response.result.value!)
                    success(data: JSON(response.result.value!))
                case .Failure:
                    self.cachedTasks.append(cachedTask)
                    self.refreshToken(failure)
                    return
                }
        }
        
    }
    
    func getJSON(path: String, parameters: [String : AnyObject]?, success: (data: JSON) -> Void, failure: (error: NSError) -> Void) {
        requestJSON(.GET, path: path, parameters: parameters, success: success, failure: failure)
    }
    
    func refreshToken(failure: (error: NSError) -> Void) {
        self.isRefreshing = true
        
        authService?.postRefreshToken({ () -> Void in
            let cachedTaskCopy = self.cachedTasks
            self.cachedTasks.removeAll()
            cachedTaskCopy.forEach { $0(nil) }
            
            self.isRefreshing = false
            }, failure: failure)
    }
    
    // User
    
    func getUserInfo(success: (data: JSON) -> Void, failure: (error: NSError) -> Void) -> Void {
        getJSON(Path.Me.rawValue, parameters: [String: String](), success: success, failure: failure)
    }
    
    // Tasks
    
    func getTasks(success: (data: JSON) -> Void, failure: (error: NSError) -> Void) {
        getJSON(Path.Tasks.rawValue, parameters: [String: String](), success: success, failure: failure)
    }
    
    func putTask(task:TaskModel, success: () -> Void, failure: (error: NSError) -> Void) {
        let path = Path.Tasks.rawValue + "/" + String(task.id)
        var parameters = [String:String]()
        if let name = task.name {
            parameters["name"] = name
        }
        if let description = task.description {
            parameters["description"] = description
        }
        requestJSON(.PUT, path: path, parameters: parameters, success: { (data) -> Void in
            success()
            }, failure: failure)
    }

    // Projects
    
    func getProjects(success: (data: JSON) -> Void, failure: (error: NSError) -> Void) {
        getJSON(Path.Projects.rawValue, parameters: [String: String](), success: success, failure: failure)
    }
    

}

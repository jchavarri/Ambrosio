//
//  APIServiceProtocol.swift
//  Ambrosio
//
//  Created by Javi on 10/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol APIServiceProtocol {
    
    func getUserInfo(success: (data: UserInfoModel) -> Void, failure: (error: NSError) -> Void)
    func getTasks(success: (data: [TaskModel]) -> Void, failure: (error: NSError) -> Void)
    func putTask(task: TaskModel, success: () -> Void, failure: (error: NSError) -> Void)

}

//
//  APIDataManagerProtocol.swift
//  Ambrosio
//
//  Created by Javi on 12/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol APIDataManagerProtocol {
    func getUserInfo(success: (data: JSON) -> Void, failure: (error: NSError) -> Void)
    func getTasks(success: (data: JSON) -> Void, failure: (error: NSError) -> Void)

}
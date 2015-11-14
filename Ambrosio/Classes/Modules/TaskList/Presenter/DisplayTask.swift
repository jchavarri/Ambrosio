//
//  DisplayTask.swift
//  Ambrosio
//
//  Created by Javi on 14/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

struct DisplayTask {
    let name : String = ""
    
    var description : String { get {
        return "\(name)"
        }}
    
    init(name: String) {
        self.name = name
    }
}
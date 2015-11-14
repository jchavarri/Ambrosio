//
//  TaskListInteractorIO.swift
//  Ambrosio
//
//  Created by Javi on 10/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol TaskListInteractorInputProtocol {
    // PRESENTER->INTERACTOR
    func findTasks()
}

protocol TaskListInteractorOutputProtocol: class {
    // INTERACTOR->PRESENTER
    func foundTasks(tasks: [TaskModel])
}

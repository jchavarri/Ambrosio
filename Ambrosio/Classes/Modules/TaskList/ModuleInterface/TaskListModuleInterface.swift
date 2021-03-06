//
//  TaskListModuleInterface.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

protocol TaskListModuleInterface
{
    // VIEW -> PRESENTER
    func addNewAlarm(task: TaskModel)
    func updateView()
}
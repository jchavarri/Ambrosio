//
//  AddAlarmInteractorIO.swift
//  Ambrosio
//
//  Created by Javi on 10/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol AddAlarmInteractorInputProtocol {
    // PRESENTER->INTERACTOR
    func saveNewTask(task: TaskModel)
}

protocol AddAlarmInteractorOutputProtocol: class {
    // INTERACTOR->PRESENTER
    func didSaveAlarm()
    func showError(error: NSError)
}

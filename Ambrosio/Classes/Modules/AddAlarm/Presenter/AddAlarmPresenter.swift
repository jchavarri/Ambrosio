//
//  AddAlarmPresenter.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

class AddAlarmPresenter: NSObject, AddAlarmModuleInterface, AddAlarmInteractorOutputProtocol
{
    var interactor: AddAlarmInteractorInputProtocol?
    weak var wireframe: AddAlarmWireframe?
    weak var userInterface: AddAlarmViewInterface?
    var addModuleDelegate : AddAlarmModuleDelegate?
    var task: TaskModel?
    
    func configureUserInterfaceForPresentation(addViewUserInterface: AddAlarmViewInterface, task: TaskModel) {
        self.task = task
    }
    
    // MARK: - AddAlarmModuleInterface methods
    
    func updateView() {
        if let task = task {
            if let taskNameString = task.name {
                userInterface?.updateTaskName(taskNameString)
            }
            userInterface?.setupSelectionButtons(task.alarm)
        }
    }
    
    func didTapCancel() {
        wireframe?.dismissAddInterface()
        addModuleDelegate?.addAlarmModuleDidCancelAction()
    }
    
    func didTapOk() {
        if let task = task {
            interactor?.saveNewTask(task)
        }
    }
    
    func didSelectWhenLeaving() {
        if task?.alarm == .WhenLeaving {
            task?.alarm = .Disabled
        }
        else {
            task?.alarm = .WhenLeaving
        }
    }
    
    func didSelectWhenArriving() {
        if task?.alarm == .WhenArriving {
            task?.alarm = .Disabled
        }
        else {
            task?.alarm = .WhenArriving
        }
    }
    
    // MARK: - AddAlarmInteractorOutputProtocol methods
    
    func didSaveAlarm() {
        wireframe?.dismissAddInterface()
        addModuleDelegate?.addAlarmModuleDidSaveAction()
    }
    
    func showError(error: NSError) {
        userInterface?.showError(error.localizedDescription)
    }
    
}

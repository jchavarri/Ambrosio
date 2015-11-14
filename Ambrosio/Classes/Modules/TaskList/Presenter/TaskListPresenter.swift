//
//  TaskListPresenter.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

class TaskListPresenter: NSObject, TaskListModuleInterface, TaskListInteractorOutputProtocol
{
    var interactor: TaskListInteractorInputProtocol?
    weak var wireframe: TaskListWireframe?
    weak var userInterface: TaskListViewInterface?

    // MARK: - TaskListModuleInterface methods
    func updateView() {
        interactor?.findTasks()
    }
    
    
    
    // MARK: - TaskListInteractorOutputProtocol methods
    func foundTasks(tasks: [TaskModel]) {
        if tasks.count == 0 {
            userInterface?.showNoContentMessage()
        } else {
            userInterface?.showTasks(tasks)
        }
    }
    

    
    // MARK: - TaskListInteractorOutputProtocol methods

}

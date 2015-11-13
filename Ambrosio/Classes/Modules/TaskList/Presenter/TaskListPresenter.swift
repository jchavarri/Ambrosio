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
    
    
    // MARK: - TaskListInteractorOutputProtocol methods
    
    
    // MARK: - TaskListInteractorOutputProtocol methods

}

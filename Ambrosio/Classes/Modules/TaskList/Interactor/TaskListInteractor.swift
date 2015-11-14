//
//  LoginInteractor.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

class TaskListInteractor: TaskListInteractorInputProtocol
{
    weak var presenter: TaskListInteractorOutputProtocol?
    var apiService: APIService?
    var authService: AuthService?
    
    func findTasks() {
        self.apiService?.getTasks({ (data) -> Void in
            self.presenter?.foundTasks(data)
            }, failure: { (error) -> Void in
                //TODO: Handle error
                self.presenter?.foundTasks([TaskModel]())
        })
    }

}

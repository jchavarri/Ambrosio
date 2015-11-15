//
//  LoginInteractor.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

class AddAlarmInteractor: AddAlarmInteractorInputProtocol
{
    weak var presenter: AddAlarmInteractorOutputProtocol?
    var apiService: APIService?
    var authService: AuthService?
    
    func saveNewTask(task: TaskModel) {
        apiService?.putTask(task, success: { () -> Void in
            self.presenter?.didSaveAlarm()
            }, failure: { (error) -> Void in
                self.presenter?.showError(error)
        })
    }


}

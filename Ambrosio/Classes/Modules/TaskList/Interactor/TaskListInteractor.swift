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
    
}

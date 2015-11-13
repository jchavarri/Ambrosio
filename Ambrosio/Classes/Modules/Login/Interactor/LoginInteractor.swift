//
//  LoginInteractor.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol
{
    weak var presenter: LoginInteractorOutputProtocol?
    var apiService: APIService?
    var authService: AuthService?
    
    func fetchInitialData() {
        if let authService = authService {
            if authService.hasAccessToken() {
                print("islogged");
                //TODO: Fetch task list
            }
            else if authService.hasAuthToken() {
                authService.postAuthToken({ () -> Void in
                    self.apiService?.getTasks({ (data) -> Void in
                        print(data)
                        self.presenter?.showTaskList()
                        }, failure: { (error) -> Void in
                            self.presenter?.showError(error.description)
                    })
                    }, failure: { (error) -> Void in
                        self.presenter?.showError(error.description)
                })
            }
        }
    }
    func startAppAuthorization() {
        presenter?.startExternalAuthProcessWithUrl(authService?.getAuthorizationURL())
    }
}

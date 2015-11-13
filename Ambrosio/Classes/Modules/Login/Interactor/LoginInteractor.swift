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
    
    private func getTasks() {
        self.apiService?.getTasks({ (data) -> Void in
            print(data)
            self.presenter?.didFinishLogin()
            }, failure: { (error) -> Void in
                self.presenter?.showError(error.description)
        })
    }
    
    func fetchInitialData() {
        if let authService = authService {
            if authService.hasAccessToken() {
                getTasks()
            }
            else if authService.hasAuthToken() {
                authService.postAuthToken({ () -> Void in
                    self.getTasks()
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

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
            self.presenter?.didFinishLogin()
            self.presenter?.stopLoadingProcess()
            }, failure: { (error) -> Void in
                self.presenter?.showError(error)
                self.presenter?.stopLoadingProcess()
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
                        self.presenter?.showError(error)
                })
            }
            else {
                self.presenter?.showLoginButton()
                self.presenter?.stopLoadingProcess()
            }
        }
        else {
            presenter?.stopLoadingProcess()
        }
    }
    func startAppAuthorization() {
        presenter?.startExternalAuthProcessWithUrl(authService?.getAuthorizationURL())
    }
}

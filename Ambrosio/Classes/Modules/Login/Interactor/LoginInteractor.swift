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
    
    private func getTasks(didEndFetching:()->Void) {
        self.apiService?.getTasks({ (data) -> Void in
            self.presenter?.didFinishLogin()
            didEndFetching()
            }, failure: { (error) -> Void in
                self.presenter?.showError(error)
                didEndFetching()
        })
    }
    
    func fetchInitialData(didEndFetching:()->Void) {
        if let authService = authService {
            if authService.hasAccessToken() {
                getTasks(didEndFetching)
            }
            else if authService.hasAuthToken() {
                authService.postAuthToken({ () -> Void in
                    self.getTasks(didEndFetching)
                    }, failure: { (error) -> Void in
                        self.presenter?.showError(error)
                })
            }
            else {
                didEndFetching()
            }
        }
        else {
            didEndFetching()
        }
    }
    func startAppAuthorization() {
        presenter?.startExternalAuthProcessWithUrl(authService?.getAuthorizationURL())
    }
}

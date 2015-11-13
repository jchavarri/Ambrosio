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
                dataManager.getAccessToken({ (error: NSError?) -> () in
                    if (error == nil) {
                        presenter?.showError(error)
                    }
                    else {
                        wireframe?.presentLoginAsRoot()
                    }
                })
                //        self.APIDataManager?.login({ [weak self] (error: NSError?, credentials: TwitterLoginItem?) -> () in
                //            if (credentials != nil) {
                //                self?.localDatamanager?.persistUserCredentials(credentials: credentials!)
                //                self?.localDatamanager?.setupLocalStorage()
                //                completion(error: nil)
                //            }
                //            else {
                //                completion(error: error)
                //            }
                //        })
                
            }
        }
    }
    func startAppAuthorization() {
        presenter?.startExternalAuthProcessWithUrl(dataManager?.getAuthorizationURL())
    }
}

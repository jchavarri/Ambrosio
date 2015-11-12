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
    var dataManager: LoginDataManager?
    
    func fetchInitialData() {
        if let dataManager = dataManager {
            if dataManager.isLogged() {
                print("islogged");
                //Fetch task list
            }
            else if dataManager.hasAuthToken() {
                dataManager.getAccessToken({ (error: NSError?) -> () in
                    if (error == nil) {
                        print("error")
                    }
                    else {
                        dataManager.setAccessToken(<#T##accessToken: String##String#>, accessTokenExpTime: <#T##NSTimeInterval#>)
                        (authToken, authTokenExpTime: expirationTime)
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

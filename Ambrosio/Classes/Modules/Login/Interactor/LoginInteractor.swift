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
    
    func login() {
        if let dataManager = dataManager {
            if dataManager.isLogged() {
                //dataManager.requestTaskList()
                print("islogged");
            }
            else if dataManager.hasAccessToken() {
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
            else {
                presenter?.startExternalAuthProcessWithUrl(dataManager.getAccessURL())
            }
        }
    }
}

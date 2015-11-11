//
//  LoginPresenter.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

class LoginPresenter: NSObject, LoginModuleInterface, LoginInteractorOutputProtocol, RootModuleDelegate
{
    var interactor: LoginInteractorInputProtocol?
    weak var wireframe: LoginWireframe?
    weak var userInterface: LoginViewInterface?

    // MARK: - LoginModuleInterface methods
    
    func userDidSelectLogin() {
        interactor?.login()
    }
    
    // MARK: - LoginInteractorOutputProtocol methods
    
    func didFinishLogin() {
        //wireframe.presentListInterface()
        print("presentListInterface")
    }
    
    func startExternalAuthProcessWithUrl(url: NSURL?) {
        if let url = url {
            userInterface?.hideLoading()
            wireframe?.launchExternalUrl(url)
        }
        else {
            userInterface?.showError("Error while creating authentication credentials");
        }
    }
    
    // MARK: - RootModuleDelegate methods
    func userDidAllowApp() {
        interactor?.login()
    }

}

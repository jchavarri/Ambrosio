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
    
    func didSelectLogin() {
        interactor?.startAppAuthorization()
    }
    
    // MARK: - RootModuleDelegate methods
    
    func didAuthorizeApp() {
        interactor?.fetchInitialData()
    }
    
    // MARK: - LoginInteractorOutputProtocol methods
    
    func didFinishLogin() {
        //wireframe.presentListInterface()
        print("presentListInterface")
    }
    
    // MARK: - LoginInteractorOutputProtocol methods
    
    func startExternalAuthProcessWithUrl(url: NSURL?) {
        if let url = url {
            userInterface?.hideLoading()
            wireframe?.launchExternalUrl(url)
        }
        else {
            userInterface?.showError("Error while creating authentication credentials");
        }
    }
    
    // Presenter -> View
    func showError(let errorMessage: String) {
        userInterface?.showError(errorMessage);
    }
    

}

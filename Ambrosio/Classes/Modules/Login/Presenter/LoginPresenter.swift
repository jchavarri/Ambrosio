//
//  LoginPresenter.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

class LoginPresenter: NSObject, LoginModuleInterface, LoginInteractorOutputProtocol
{
    var interactor: LoginInteractorInputProtocol?
    var delegate: LoginModuleDelegate?
    weak var wireframe: LoginWireframe?
    weak var userInterface: LoginViewInterface?

    // MARK: - LoginModuleInterface methods
    
    func didSelectLogin() {
        // No need to show loader
        interactor?.startAppAuthorization()
    }
    
    func updateView() {
        userInterface?.showLoader()
        interactor?.fetchInitialData({ () -> Void in
            self.userInterface?.hideLoader()
        })
    }
    
    // MARK: - RootModuleDelegate methods
    
    func didAuthorizeApp() {
        userInterface?.showLoader()
        interactor?.fetchInitialData({ () -> Void in
            self.userInterface?.hideLoader()
        })
    }
    
    // MARK: - LoginInteractorOutputProtocol methods
    
    func didFinishLogin() {
        userInterface?.hideLoader()
        delegate?.didFinishLogin()
    }
    
    func showError(error:String) {
        userInterface?.hideLoader()
        userInterface?.showError(error)
    }
    
    // MARK: - LoginInteractorOutputProtocol methods
    
    func startExternalAuthProcessWithUrl(url: NSURL?) {
        if let url = url {
            userInterface?.hideLoader()
            wireframe?.launchExternalUrl(url)
        }
        else {
            userInterface?.showError("Error while creating authentication credentials");
        }
    }
    
}

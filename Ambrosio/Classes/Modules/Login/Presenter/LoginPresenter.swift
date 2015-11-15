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
        userInterface?.startLoadingProcess()
        interactor?.fetchInitialData()
    }
    
    // MARK: - RootModuleDelegate methods
    
    func didAuthorizeApp() {
        updateView()
    }
    
    // MARK: - LoginInteractorOutputProtocol methods
    
    func didFinishLogin() {
        userInterface?.stopLoadingProcess()
        delegate?.didFinishLogin()
    }
    
    func showError(error:NSError) {
        userInterface?.stopLoadingProcess()
        userInterface?.showError(error.localizedDescription)
    }
    
    func showLoginButton() {
        userInterface?.showLoginButton()
    }
    
    func stopLoadingProcess() {
        userInterface?.stopLoadingProcess()
    }
    
    // MARK: - LoginInteractorOutputProtocol methods
    
    func startExternalAuthProcessWithUrl(url: NSURL?) {
        stopLoadingProcess()
        if let url = url {
            wireframe?.launchExternalUrl(url)
        }
        else {
            userInterface?.showError("Error while creating authentication credentials");
        }
    }
    
}

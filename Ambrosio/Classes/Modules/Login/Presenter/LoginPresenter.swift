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
    
    func showError(error:String) {
        userInterface?.showError(error)
    }
    
    func showTaskList() {
        delegate?.didLoadTaskList()
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
    
}

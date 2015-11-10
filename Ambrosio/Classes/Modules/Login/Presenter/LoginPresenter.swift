//
//  LoginPresenter.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

class LoginPresenter: NSObject, LoginModuleInterface
{
    var interactor: LoginInteractor?
    weak var wireframe: LoginWireframe?
    weak var userInterface: LoginViewInterface?

    // MARK: - LoginModuleInterface methods
    // implement module interface here
}

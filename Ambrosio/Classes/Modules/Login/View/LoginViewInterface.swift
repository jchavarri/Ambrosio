//
//  LoginView.h
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

protocol LoginViewInterface: class
{
    // presenter -> view
    func showError(let errorMessage: String)
    func startLoadingProcess()
    func stopLoadingProcess()
    func showLoginButton()
}

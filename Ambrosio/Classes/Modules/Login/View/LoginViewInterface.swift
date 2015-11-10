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
    // PRESENTER -> VIEW
    func showError(let errorMessage: String)
    func showLoading()
    func hideLoading()

}

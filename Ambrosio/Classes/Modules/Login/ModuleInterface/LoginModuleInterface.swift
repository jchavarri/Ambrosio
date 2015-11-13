//
//  LoginModuleInterface.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

protocol LoginModuleInterface
{
    // VIEW -> PRESENTER
    func didSelectLogin()
}

protocol LoginModuleDelegate
{
    // MODULE -> OTHER MODULES
    func didLoadTaskList()
}
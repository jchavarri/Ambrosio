//
//  LoginInteractorIO.swift
//  Ambrosio
//
//  Created by Javi on 10/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol LoginInteractorInputProtocol {
    // PRESENTER->INTERACTOR
    func startAppAuthorization()
    func fetchInitialData()
}

protocol LoginInteractorOutputProtocol: class {
    // INTERACTOR->PRESENTER
    func didFinishLogin()
    func startExternalAuthProcessWithUrl(url:NSURL?)
    func showError(error:String)
    func showTaskList()
}

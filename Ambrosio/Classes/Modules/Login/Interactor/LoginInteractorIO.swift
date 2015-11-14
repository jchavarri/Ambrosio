//
//  LoginInteractorIO.swift
//  Ambrosio
//
//  Created by Javi on 10/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

protocol LoginInteractorInputProtocol {
    // presenter -> interactor
    func startAppAuthorization()
    func fetchInitialData(didEndFetching:()->Void)
}

protocol LoginInteractorOutputProtocol: class {
    // interactor -> presenter
    func didFinishLogin()
    func startExternalAuthProcessWithUrl(url:NSURL?)
    func showError(error:NSError)
}

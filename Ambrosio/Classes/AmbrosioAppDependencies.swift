//
//  AmbrosioAppDependencies.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation
import UIKit

class AmbrosioAppDependencies: NSObject
{
    let loginWireframe = LoginWireframe()
    let rootPresenter = RootPresenter()
    
    class func initWithWindow(window: UIWindow) -> AmbrosioAppDependencies
    {

        let obj = AmbrosioAppDependencies()
        obj.configureDependencies(window)

        return obj
    }

    func installRootViewControllerIntoWindow(window: UIWindow) {
        let rootWireframe = RootWireframe.init(window: window)
        // presenter <-> wireframe
        rootPresenter.wireframe = rootWireframe
        rootWireframe.presenter = rootPresenter
        
        // connect wireframes
        rootWireframe.loginWireframe = loginWireframe
        
        rootWireframe.presentLoginAsRoot()
    }
    
    func handleOpenURL(url: NSURL) -> Bool {
        return rootPresenter.handleOpenURL(url);
    }
    
    func configureDependencies(window: UIWindow)
    {
        // -----
        // root classes
        // *** add datastore

        // ------------------------------------------------------------------
        // begin Login module
        
        // instantiate classes
        let loginPresenter: LoginPresenter      = LoginPresenter()
        let loginDataManager: LoginDataManager  = LoginDataManager()
        let loginInteractor: LoginInteractor    = LoginInteractor()
        
        // presenter <-> wireframe
        loginPresenter.wireframe = loginWireframe
        loginWireframe.presenter = loginPresenter
        
        // presenter <-> interactor
        loginPresenter.interactor = loginInteractor
        loginInteractor.presenter = loginPresenter
        
        // interactor -> data_manager
        loginInteractor.dataManager = loginDataManager
        
        // data_manager -> data_store
        // *** connect datastore
        
        // connect wireframes
        // *** connect more wireframes
        
        // configure delegate
        // *** add delegate here if needed
        
        // end Login module
        // ------------------------------------------------------------------
    }
}

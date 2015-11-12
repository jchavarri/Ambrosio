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
    let authStore           = RedboothAuthStore()
    let loginWireframe      = LoginWireframe()
    let loginPresenter      = LoginPresenter()
    let rootPresenter       = RootPresenter()
    let rootDataManager     = RootDataManager()
    
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
        
        // presenter -> data_manager
        rootPresenter.dataManager = rootDataManager
        
        // connect wireframes
        rootWireframe.loginWireframe = loginWireframe
        
        // data_manager -> data_store
        rootDataManager.authStore = authStore
        
        rootWireframe.presentLoginAsRoot()
    }
    
    func handleOpenURL(url: NSURL) -> Bool {
        return rootPresenter.handleOpenURL(url);
    }
    
    func configureDependencies(window: UIWindow)
    {
        // -----
        // root classes
        let apiManager = RedboothAPIManager()
        apiManager.authStore = authStore
        // ------------------------------------------------------------------
        // begin Login module
        
        // instantiate classes
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
        loginDataManager.authStore = authStore
        loginDataManager.apiManager = apiManager
        
        // connect wireframes
        // *** connect more wireframes
        
        // configure delegate
        // *** add delegate here if needed
        
        // end Login module
        // ------------------------------------------------------------------
    }
}

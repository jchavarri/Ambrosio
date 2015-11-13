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
    let loginWireframe      = LoginWireframe()
    let loginPresenter      = LoginPresenter()
    let rootPresenter       = RootPresenter()
    let authService = AuthService()
    
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
        
        // delegate
        rootPresenter.rootModuleDelegate = loginPresenter
        
        // services
        rootPresenter.authService = authService
        
        rootWireframe.presentLoginAsRoot()
    }
    
    func handleOpenURL(url: NSURL) -> Bool {
        return rootPresenter.handleOpenURL(url);
    }
    
    func configureDependencies(window: UIWindow)
    {
        // -----
        // services
        let apiService = APIService()
        let apiDataManager = APIDataManager()
        apiService.dataManager = apiDataManager
        
        let authDataManager = AuthDataManager()
        let authStore = AuthStore()
        authService.dataManager = authDataManager
        authService.store = authStore
        authDataManager.store = authStore
        // ------------------------------------------------------------------
        // begin Login module
        
        // instantiate classes
        let loginInteractor: LoginInteractor    = LoginInteractor()
        
        // presenter <-> wireframe
        loginPresenter.wireframe = loginWireframe
        loginWireframe.presenter = loginPresenter
        
        // presenter <-> interactor
        loginPresenter.interactor = loginInteractor
        loginInteractor.presenter = loginPresenter
        
        // interactor -> services
        loginInteractor.apiService = apiService
        loginInteractor.authService = authService
        
        // connect wireframes
        // *** connect more wireframes
        
        // configure delegate
        // *** add delegate here if needed
        
        // end Login module
        // ------------------------------------------------------------------
    }
}

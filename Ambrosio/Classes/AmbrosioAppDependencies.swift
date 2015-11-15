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
    // Services
    let rootPresenter       = RootPresenter()
    let authService         = AuthService()
    let locationService     = LocationService()
    let notificationService = NotificationService()

    // Modules
    let loginWireframe      = LoginWireframe()
    let loginPresenter      = LoginPresenter()
    
    let taskListWireframe   = TaskListWireframe()
    let taskListPresenter      = TaskListPresenter()
    
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
        rootWireframe.taskListWireframe = taskListWireframe
        
        // services
        rootPresenter.authService = authService
        
        // login delegate
        loginPresenter.delegate = rootPresenter
        
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
        let apiDescriptionWrapper = APITaskDescriptionWrapper()
        apiDataManager.authService = authService
        apiService.dataManager = apiDataManager
        apiService.descriptionWrapper = apiDescriptionWrapper
        
        let authDataManager = AuthDataManager()
        let authStore = AuthStore()
        authService.dataManager = authDataManager
        authService.store = authStore
        authDataManager.store = authStore
        
        locationService.startRangingWithDelegate(notificationService)
        notificationService.apiService = apiService

        // ------------------------------------------------------------------
        // begin AddAlarm module
        
        // instantiate classes
        let addAlarmInteractor: AddAlarmInteractor = AddAlarmInteractor()
        let addAlarmPresenter: AddAlarmPresenter = AddAlarmPresenter()
        let addAlarmWireframe: AddAlarmWireframe = AddAlarmWireframe()
        
        // presenter <-> wireframe
        addAlarmPresenter.wireframe = addAlarmWireframe
        addAlarmWireframe.presenter = addAlarmPresenter
        
        // presenter <-> interactor
        addAlarmPresenter.interactor = addAlarmInteractor
        addAlarmInteractor.presenter = addAlarmPresenter
        
        // interactor -> services
        addAlarmInteractor.apiService = apiService
        addAlarmInteractor.authService = authService
        
        // connect wireframes
        // *** connect more wireframes
        
        // configure delegate
        addAlarmPresenter.addModuleDelegate = taskListPresenter
        
        // end AddAlarm module
        // ------------------------------------------------------------------
        
        // ------------------------------------------------------------------
        // begin TaskList module
        
        // instantiate classes
        let taskListInteractor: TaskListInteractor    = TaskListInteractor()
        
        // presenter <-> wireframe
        taskListPresenter.wireframe = taskListWireframe
        taskListWireframe.presenter = taskListPresenter
        
        // presenter <-> interactor
        taskListPresenter.interactor = taskListInteractor
        taskListInteractor.presenter = taskListPresenter
        
        // interactor -> services
        taskListInteractor.apiService = apiService
        taskListInteractor.authService = authService
        
        // connect wireframes
        taskListWireframe.addAlarmWireframe = addAlarmWireframe
        
        // configure delegate
        // *** add delegate here if needed
        
        // end TaskList module
        // ------------------------------------------------------------------

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

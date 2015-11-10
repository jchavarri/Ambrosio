//
//  RootWireframe.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation
import UIKit

class RootWireframe: NSObject
{
    var window: UIWindow?
    var loginWireframe:LoginWireframe?
    var presenter: RootPresenter?
    
    init(window: UIWindow)
    {
        super.init()
        self.window = window
    }
    
    func presentLoginAsRoot() {
        let navigationController = navigationControllerFromWindow(window!)
        loginWireframe?.presentSelfAsRootForNavigationController(navigationController)
    }
    
    func showRootViewController(viewController: UIViewController, inWindow: UIWindow) {
        let navigationController = navigationControllerFromWindow(inWindow)
        navigationController.viewControllers = [viewController]
    }
    
    func navigationControllerFromWindow(window: UIWindow) -> UINavigationController {
        let navigationController = window.rootViewController as! UINavigationController
        return navigationController
    }

}

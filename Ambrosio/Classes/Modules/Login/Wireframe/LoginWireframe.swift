//
//  LoginWireframe.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation
import UIKit

let LoginViewControllerIdentifier = "LoginViewController"

class LoginWireframe: NSObject
{
    var presenter: LoginPresenter?
    var viewController: LoginViewController?

    func presentSelfAsRootForNavigationController(navigationController: UINavigationController) {
        let newViewController = loginViewControllerFromStoryboard()
        newViewController.eventHandler = presenter
        self.viewController = newViewController
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        navigationController.viewControllers = [newViewController]
    }
    
    func loginViewControllerFromStoryboard() -> LoginViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(LoginViewControllerIdentifier) as! LoginViewController
        return viewController
    }
    
    func launchExternalUrl(url: NSURL) {
        UIApplication.sharedApplication().openURL(url)
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }

}

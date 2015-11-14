//
//  AddAlarmWireframe.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation
import UIKit

let AddAlarmViewControllerIdentifier = "AddAlarmViewController"

class AddAlarmWireframe: NSObject
{
    var presenter: AddAlarmPresenter?
    var viewController: AddAlarmViewController?

    func presentAddInterfaceFromViewController(viewController: UIViewController, task: TaskModel) {
        let newViewController = addViewController()
        newViewController.eventHandler = presenter
        newViewController.modalPresentationStyle = .OverCurrentContext
        
        presenter?.configureUserInterfaceForPresentation(newViewController, task: task)
        
        viewController.presentViewController(newViewController, animated: true, completion: nil)
        
        self.viewController = newViewController
    
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        
    }
    
    func dismissAddInterface() {
        viewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addViewController() -> AddAlarmViewController {
        let storyboard = mainStoryboard()
        let addViewController: AddAlarmViewController = storyboard.instantiateViewControllerWithIdentifier(AddAlarmViewControllerIdentifier) as! AddAlarmViewController
        return addViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
    

}

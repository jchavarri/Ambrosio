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

    func presentAddInterfaceFromViewController(viewController: UIViewController) {
        let newViewController = addViewController()
        newViewController.eventHandler = presenter
        newViewController.modalPresentationStyle = .OverCurrentContext
        
        presenter?.configureUserInterfaceForPresentation(newViewController)
        
        viewController.presentViewController(newViewController, animated: true, completion: nil)
        
        self.viewController = newViewController
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

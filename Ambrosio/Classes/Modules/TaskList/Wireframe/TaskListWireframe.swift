//
//  TaskListWireframe.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation
import UIKit

let TaskListViewControllerIdentifier = "TaskListViewController"

class TaskListWireframe: NSObject
{
    var presenter: TaskListPresenter?
    var viewController: TaskListViewController?

    func presentSelfAsRootForNavigationController(navigationController: UINavigationController) {
        let newViewController = taskListViewControllerFromStoryboard()
        newViewController.eventHandler = presenter
        self.viewController = newViewController
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        let transition = CATransition()
        transition.duration = 0.625
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        navigationController.view.layer.addAnimation(transition, forKey: "crossFade")
        navigationController.setViewControllers([newViewController], animated: false)
    }
    
    func taskListViewControllerFromStoryboard() -> TaskListViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(TaskListViewControllerIdentifier) as! TaskListViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    

}

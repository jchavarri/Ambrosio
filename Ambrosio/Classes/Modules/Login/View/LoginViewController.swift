//
//  LoginViewController.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import UIKit

class LoginViewController: UIViewController, LoginViewInterface
{
    var eventHandler: LoginModuleInterface?

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        eventHandler?.updateView()
    }
    
    func configureView() {
        // Animate logo elements to go up and down
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    // MARK: - LoginViewInterface methods

    func showError(let errorMessage: String) {
        //TODO
    }
    
    func showLoading() {
        //TODO
    }
    
    func hideLoading() {
        //TODO
    }

    // MARK: - Button event handlers

    @IBAction func login(sender: UIButton) {
        eventHandler?.didSelectLogin()
    }

}

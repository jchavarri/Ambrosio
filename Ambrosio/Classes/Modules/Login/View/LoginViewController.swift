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
    @IBOutlet weak var loader: UIActivityIndicatorView?
    @IBOutlet weak var error: UILabel?
    
    // MARK: - View lifecycle

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        eventHandler?.updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    func configureView() {
        loader?.hidden = true
        error?.text = ""
        // Animate logo elements to go up and down
    }
    
    // MARK: - LoginViewInterface methods

    func showError(let errorMessage: String) {
        error?.text = errorMessage
    }
    
    func showLoader() {
        loader?.hidden = false
        loader?.startAnimating()
    }
    
    func hideLoader() {
        loader?.stopAnimating()
        loader?.hidden = true
    }

    // MARK: - Button event handlers

    @IBAction func login(sender: UIButton) {
        error?.text = ""
        eventHandler?.didSelectLogin()
    }

}

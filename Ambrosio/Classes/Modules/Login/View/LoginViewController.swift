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

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    // MARK: - LoginViewInterface methods

    // *** implement view_interface methods here

    // MARK: - Button event handlers

    @IBAction func login(sender: UIButton) {
        if let url = NSURL(string : "https://redbooth.com/oauth2/authorize?client_id=6968954a31fa53e8073d1618d5c7c8108d7d32252b26180eb69806b2532e1f15&redirect_uri=ambrosio%3A%2F%2Freturn-uri&response_type=token") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

}

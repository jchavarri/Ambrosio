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
    @IBOutlet weak var redBowImage: UIImageView?
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
        redBowImage?.alpha = 0
        error?.text = ""
        //Red bow animation
        let spins: Double = 2
        let duration: Double = 2
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z";
        animation.fromValue = 0;
        animation.toValue = (2 * M_PI) * spins;
        animation.duration = duration;
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.repeatCount = Float.infinity
        redBowImage?.layer.addAnimation(animation, forKey: "basic")

        // Animate logo elements to go up and down
    }
    
    // MARK: - LoginViewInterface methods

    func showError(let errorMessage: String) {
        error?.text = errorMessage
    }
    
    func showLoader() {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.redBowImage?.alpha = 1
        }
    }
    
    func hideLoader() {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.redBowImage?.alpha = 0
        }
    }

    // MARK: - Button event handlers

    @IBAction func login(sender: UIButton) {
        error?.text = ""
        eventHandler?.didSelectLogin()
    }

}

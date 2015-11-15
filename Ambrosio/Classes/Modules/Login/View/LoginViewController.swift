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
    private var isAnimatingLoader:Bool?
    var eventHandler: LoginModuleInterface?
    @IBOutlet weak var redBowImage: UIImageView?
    @IBOutlet weak var error: UILabel?
    @IBOutlet weak var loginButton: UIButton?
    
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
    
    //Private methods
    private func animateLayer() {
    
    }

    func configureView() {
        error?.text = ""
        isAnimatingLoader = false
        loginButton?.alpha = 0
    }
    
    // MARK: - LoginViewInterface methods

    func showError(let errorMessage: String) {
        error?.text = errorMessage
    }
    
    func startLoadingProcess() {
        if isAnimatingLoader == false {
            isAnimatingLoader = true
            //Red bow animation
            let spins: Double = 4
            let duration: Double = 2
            let animation = CABasicAnimation()
            animation.keyPath = "transform.rotation.z";
            animation.fromValue = 0;
            animation.toValue = (2 * M_PI) * spins;
            animation.duration = duration;
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.repeatCount = Float.infinity
            redBowImage?.layer.addAnimation(animation, forKey: "basic")
        }
        UIView.animateWithDuration(0.4) { () -> Void in
            self.loginButton?.alpha = 0
        }
    }
    
    func stopLoadingProcess() {
        if isAnimatingLoader == true {
            isAnimatingLoader = false
            if let redBowImage = redBowImage {
                let layer = redBowImage.layer
                layer.removeAllAnimations()
                if let presentationLayer = layer.presentationLayer() {
                    let duration: Double = 0.5
                    let animation = CABasicAnimation()
                    animation.keyPath = "transform.rotation.z";
                    let currentValue = presentationLayer.valueForKeyPath(animation.keyPath!)
                    //Red bow animation
                    animation.fromValue = currentValue?.doubleValue
                    animation.toValue = ceil(currentValue!.doubleValue / M_PI) * M_PI;
                    animation.duration = duration;
                    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                    animation.repeatCount = 0
                    layer.addAnimation(animation, forKey: "basic")
                }
            }
        }
        showLoginButton()
    }
    
    func showLoginButton() {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.loginButton?.alpha = 1
        }
    }

    // MARK: - Button event handlers

    @IBAction func login(sender: UIButton) {
        error?.text = ""
        eventHandler?.didSelectLogin()
    }

}

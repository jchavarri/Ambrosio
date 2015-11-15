//
//  AddAlarmViewController.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import UIKit

var AddAlarmCellIdentifier = "AddAlarmCell"

class AddAlarmViewController: UIViewController, AddAlarmViewInterface {
    var eventHandler: AddAlarmModuleInterface?
    @IBOutlet weak var taskName : UILabel?
    @IBOutlet weak var error : UILabel?
    @IBOutlet weak var whenArrivingButton : UIButton?
    @IBOutlet weak var whenLeavingButton : UIButton?
    @IBOutlet weak var whenILeaveLabel : UILabel?
    @IBOutlet weak var whenIArriveLabel : UILabel?
    @IBOutlet weak var containerView : UIView?
    
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
        error?.alpha = 0
        containerView?.layer.borderWidth = 0.5
        containerView?.layer.cornerRadius = 5.0
        containerView?.layer.borderColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0).CGColor
    }
    
    // Actions
    @IBAction func didTapCancel(sender: AnyObject) {
        eventHandler?.didTapCancel()
    }
    
    @IBAction func didTapOk(sender: AnyObject) {
        eventHandler?.didTapOk()
    }
    
    @IBAction func didSelectWhenArriving(sender: AnyObject) {
        eventHandler?.didSelectWhenArriving()
        if let button = whenArrivingButton {
            button.selected = !button.selected
            button.alpha = button.selected ? 1 : 0.25
            whenIArriveLabel?.alpha = button.selected ? 1 : 0.25
            whenILeaveLabel?.alpha = 0.25
            whenLeavingButton?.alpha = 0.25
        }
        whenLeavingButton?.selected = false
    }
    
    @IBAction func didSelectWhenLeaving(sender: AnyObject) {
        eventHandler?.didSelectWhenLeaving()
        if let button = whenLeavingButton {
            button.selected = !button.selected
            button.alpha = button.selected ? 1 : 0.25
            whenILeaveLabel?.alpha = button.selected ? 1 : 0.25
            whenIArriveLabel?.alpha = 0.25
            whenArrivingButton?.alpha = 0.25
        }
        whenArrivingButton?.selected = false
    }
    
    // MARK: - AddAlarmViewInterface
    func updateTaskName(taskNameString: String) {
        taskName?.text = taskNameString
    }
    func setupSelectionButtons(alarmStatus: AlarmStatus) {
        switch alarmStatus {
        case .WhenArriving:
            whenArrivingButton?.selected = true
            whenArrivingButton?.alpha = 1
            whenLeavingButton?.alpha = 0.25
            whenIArriveLabel?.alpha = 1
            whenILeaveLabel?.alpha = 0.25
        case .WhenLeaving:
            whenLeavingButton?.selected = true
            whenLeavingButton?.alpha = 1
            whenArrivingButton?.alpha = 0.25
            whenILeaveLabel?.alpha = 1
            whenIArriveLabel?.alpha = 0.25
        default:
            whenLeavingButton?.alpha = 0.25
            whenArrivingButton?.alpha = 0.25
            whenILeaveLabel?.alpha = 0.25
            whenIArriveLabel?.alpha = 0.25
        }
    }

    func showError(error: String) {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.error?.alpha = 1
        }
    }
}

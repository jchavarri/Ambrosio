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
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        whenArrivingButton?.selected = true
        whenLeavingButton?.selected = false
    }
    
    @IBAction func didSelectWhenLeaving(sender: AnyObject) {
        eventHandler?.didSelectWhenLeaving()
        whenLeavingButton?.selected = true
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
        case .WhenLeaving:
            whenLeavingButton?.selected = true
        default:
            break
        }
    }

    func showError(error: String) {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.error?.alpha = 1
        }
    }
}

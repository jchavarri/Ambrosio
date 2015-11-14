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
    }
    
    // Actions
    @IBAction func cancel(sender: AnyObject) {
        eventHandler?.cancelAddAction()
    }
    
    // Actions
    @IBAction func addAlarm(sender: AnyObject) {
        eventHandler?.saveAddActionWithName("test")
    }
    




}

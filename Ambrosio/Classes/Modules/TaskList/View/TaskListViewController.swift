//
//  TaskListViewController.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import UIKit

var TaskListCellIdentifier = "TaskListCell"

class TaskListViewController: UITableViewController, TaskListViewInterface {
    var eventHandler: TaskListModuleInterface?
    var strongTableView : UITableView?
    var dataProperty : [TaskModel]?
    
    @IBOutlet var noContentView : UIView?
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        eventHandler?.updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strongTableView = tableView
        configureView()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    func configureView() {
    }
    


    // MARK: - TaskListViewInterface methods
    func reloadData() {
        tableView.reloadData()
    }
    
    func showTasks(data: [TaskModel]) {
        view = strongTableView
        dataProperty = data
        tableView.reloadData()
    }
    
    func showNoContentMessage() {
        view = noContentView
    }

    // MARK: - TaskListViewInterface methods
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataProperty = dataProperty  {
            return dataProperty.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let taskItem = dataProperty![indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TaskListCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = taskItem.name;
//        cell.detailTextLabel.text = upcomingItem.dueDate;
//        cell.imageView.image = UIImage(named: upcomingSection!.imageName)
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        
        return cell
    }


}

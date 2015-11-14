//
//  TaskListView.h
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

protocol TaskListViewInterface: class
{
    // PRESENTER -> VIEW
    func reloadData ()
    func showTasks(data: [TaskModel])
    func showNoContentMessage()
}

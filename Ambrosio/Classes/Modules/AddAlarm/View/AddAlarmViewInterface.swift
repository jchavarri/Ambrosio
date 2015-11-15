//
//  AddAlarmView.h
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

protocol AddAlarmViewInterface: class
{
    // PRESENTER -> VIEW
    func updateTaskName(taskName: String)
    func setupSelectionButtons(alarmStatus: AlarmStatus)
    func showError(error: String)
}

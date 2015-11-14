//
//  LoginInteractor.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

class AddAlarmInteractor: AddAlarmInteractorInputProtocol
{
    weak var presenter: AddAlarmInteractorOutputProtocol?
    var apiService: APIService?
    var authService: AuthService?
    
    func saveNewEntryWithName(name: NSString) {
//        let newEntry = TodoItem(dueDate: dueDate, name: name as String)
//        addDataManager?.addNewEntry(newEntry)
    }


}

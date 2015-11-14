//
//  AddAlarmModuleInterface.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

protocol AddAlarmModuleInterface
{
    // VIEW -> PRESENTER
    func cancelAddAction()
    func saveAddActionWithName(name: NSString)
    func updateView()
}
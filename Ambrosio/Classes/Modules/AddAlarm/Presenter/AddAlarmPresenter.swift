//
//  AddAlarmPresenter.swift
//  Ambrosio
//
//  Created by Javier Chvarri on 09/11/15.
//
//

import Foundation

class AddAlarmPresenter: NSObject, AddAlarmModuleInterface, AddAlarmInteractorOutputProtocol
{
    var interactor: AddAlarmInteractorInputProtocol?
    weak var wireframe: AddAlarmWireframe?
    weak var userInterface: AddAlarmViewInterface?
    var addModuleDelegate : AddAlarmModuleDelegate?
    
    // MARK: - AddAlarmModuleInterface methods
    func cancelAddAction() {
        wireframe?.dismissAddInterface()
        addModuleDelegate?.addAlarmModuleDidCancelAction()
    }
    
    func saveAddActionWithName(name: NSString) {
        interactor?.saveNewEntryWithName(name)
        wireframe?.dismissAddInterface()
        addModuleDelegate?.addAlarmModuleDidSaveAction()
    }
    
    
    func configureUserInterfaceForPresentation(addViewUserInterface: AddAlarmViewInterface) {
    }
    
    // MARK: - AddAlarmInteractorOutputProtocol methods
    
    // MARK: - AddAlarmInteractorOutputProtocol methods

}

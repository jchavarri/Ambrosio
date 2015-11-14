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

    // MARK: - AddAlarmModuleInterface methods
    func updateView() {
    }
    
    func configureUserInterfaceForPresentation(addViewUserInterface: AddAlarmViewInterface) {
    }
    
    // MARK: - AddAlarmInteractorOutputProtocol methods
    
    // MARK: - AddAlarmInteractorOutputProtocol methods

}

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
    func didTapCancel()
    func didTapOk()
    func didSelectWhenArriving()
    func didSelectWhenLeaving()
    func updateView()
}
//
//  RootPresenter.swift
//  Ambrosio
//
//  Created by Javi on 09/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

class RootPresenter: NSObject, RootModuleInterface
{
//    var interactor: RootInteractor?
    weak var wireframe: RootWireframe?
    var rootModuleDelegate : RootModuleDelegate?
    
    private struct UrlSchemes{
        static let redboothUrlScheme = "ambrosio"
    }
    
    func handleOpenURL(url:NSURL) -> Bool {
        if(url.scheme.isEqual(UrlSchemes.redboothUrlScheme)){
            // TODO: We should check the path as well, there could me more cases than 'redirect-uri'
            var results = [String:String]()
            let pathAndQuery = url.absoluteString.componentsSeparatedByString("#")
            if pathAndQuery.count > 1 {
                let query = pathAndQuery[1]
                let keyValues = query.componentsSeparatedByString("&")
                if keyValues.count > 0 {
                    for pair in keyValues {
                        let kv = pair.componentsSeparatedByString("=")
                        if kv.count > 1 {
                            results.updateValue(kv[1], forKey: kv[0])
                        }
                    }
                    if let access_token = results["access_token"] {
                        allowAccessWithToken(access_token)
                        return true
                    }
                }
            }
            return false
        }
        else {
            return false
        }
    }
    
    // MARK: - RootModuleInterface methods
    func allowAccessWithToken(code: String) {
        // Maybe save the code?
        // rootInteractor?.saveCode(code)
        
        // Make sure the login controller is root
        wireframe?.presentLoginAsRoot()
        
        // Call delegate method
        rootModuleDelegate?.rootModuleDidAllowAccess(code)
    }

}

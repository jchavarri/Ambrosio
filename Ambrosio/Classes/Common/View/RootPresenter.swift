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
    var dataManager: RootDataManager?
    var rootModuleDelegate: RootModuleDelegate?
    
    private struct UrlSchemes{
        static let redboothUrlScheme = "ambrosio"
    }
    
    func handleOpenURL(url:NSURL) -> Bool {
        if(url.scheme.isEqual(UrlSchemes.redboothUrlScheme)){
            // TODO: We should check the path as well, there could be more cases than 'redirect-uri'
            var urlParams = [String:String]()
            let pathAndQuery = url.absoluteString.componentsSeparatedByString("#")
            if pathAndQuery.count > 1 {
                let query = pathAndQuery[1]
                let keyValues = query.componentsSeparatedByString("&")
                if keyValues.count > 0 {
                    for pair in keyValues {
                        let kv = pair.componentsSeparatedByString("=")
                        if kv.count > 1 {
                            urlParams.updateValue(kv[1], forKey: kv[0])
                        }
                    }
                    if let accessToken = urlParams["access_token"] {
                        if let expirationTimeString = urlParams["expires_in"] {
                            if let expirationTime = NSTimeInterval(expirationTimeString) {
                                didAuthorizeWithToken(accessToken, expirationTime: expirationTime)
                                return true
                            }
                        }
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
    func didAuthorizeWithToken(authToken: String, expirationTime: NSTimeInterval) {
        // Make sure the login controller is root
        wireframe?.presentLoginAsRoot()
        
        if ((dataManager?.setAuthToken(authToken, authTokenExpTime: expirationTime)) != nil) {
            // Notify delegate
            rootModuleDelegate?.userDidAllowApp()
        }
        //TODO: Handle error
    }

}

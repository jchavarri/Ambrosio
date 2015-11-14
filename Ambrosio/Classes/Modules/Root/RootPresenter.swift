//
//  RootPresenter.swift
//  Ambrosio
//
//  Created by Javi on 09/11/15.
//  Copyright © 2015 JCH. All rights reserved.
//

import Foundation

class RootPresenter: NSObject, RootModuleInterface, LoginModuleDelegate
{
//    var interactor: RootInteractor?
    var wireframe: RootWireframe?
    var authService: AuthServiceProtocol?
    
    private struct UrlSchemes{
        static let redboothUrlScheme = "ambrosio"
    }
    
    func handleOpenURL(url:NSURL) -> Bool {
        if(url.scheme.isEqual(UrlSchemes.redboothUrlScheme)){
            // TODO: We should check the path as well, there could be more cases than 'redirect-uri'
            var urlParams = [String:String]()
            // 'response_type=token' doesn't allow to refresh later, so using '?' instead of '#'
            let pathAndQuery = url.absoluteString.componentsSeparatedByString("?")
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
                    if let accessCode = urlParams["code"] {
                        didAuthorizeWithToken(accessCode, expirationTime: 7200)
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
    
    func loadLaunchWireframe() {
        if let authService = authService {
            if authService.hasAccessToken() {
                wireframe?.presentTaskListAsRoot()
            }
            else {
                // Try to refresh
                authService.postRefreshToken({ () -> Void in
                    self.wireframe?.presentTaskListAsRoot()
                    }, failure: { (error) -> Void in
                        self.wireframe?.presentLoginAsRoot()
                })
            }
        }
        else {
            wireframe?.presentLoginAsRoot()
        }
    }
    
    // MARK: - RootModuleInterface methods
    func didAuthorizeWithToken(authToken: String, expirationTime: NSTimeInterval) {
        authService?.setAuthToken(authToken, authTokenExpTime: expirationTime)
        wireframe?.didAuthorizeApp()
        
    }
    
    // MARK: - LoginModuleDelegate methods
    func didFinishLogin() {
        wireframe?.presentTaskListAsRoot()
    }
}

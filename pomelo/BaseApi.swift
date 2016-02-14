//
//  BaseApi.swift
//  pomelo
//
//  Created by zhouqi on 16/1/19.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BaseApi: NSObject {
    static let baseUrl = "https://zhouqi.work/pomelo/api/v1"
    
    func get(restUrl: String, parameters: [String: AnyObject]? = nil, callback: (JSON) -> Void, failedCallback: (JSON) -> Void) -> Void {
        let url = BaseApi.baseUrl + restUrl
        let token = NSUserDefaults.standardUserDefaults().stringForKey("token")
        var headers = ["abc": "bcd"]
        if token != nil {
            headers = ["token": token!]
        }
        let request = Alamofire.request(.GET, url, headers: headers, parameters: parameters)
        request.responseJSON {
            response in
            if let value = response.result.value {
                let json = JSON(value)
                callback(json)
            }
        }
    }
    
    func post(restUrl: String, parameters: [String: AnyObject]? = nil, callback: (JSON) -> Void, failedCallback: (JSON) -> Void) -> Void {
        let url = BaseApi.baseUrl + restUrl
        let token = NSUserDefaults.standardUserDefaults().stringForKey("token")
        var headers = ["abc": "bcd"]
        if token != nil {
            headers = ["token": token!]
        }
        let request = Alamofire.request(.POST, url, headers: headers, parameters: parameters)
        request.responseJSON {
            response in
            if let value = response.result.value {
                let json = JSON(value)
                callback(json)
            }
        }
    }
    
    func ensureUserLogin() -> User? {
        let user:User? = User.getSelfProfile()
        if user == nil {
            let rootController = UIApplication.sharedApplication().delegate!.window!?.rootViewController as! RootController
            rootController.toRegister()
        }
        return user
    }
    
}

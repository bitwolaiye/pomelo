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
    
    func upload(imageData: NSData, callback:(String) -> Void) {
        let timestamp:Int = Int(NSDate().timeIntervalSince1970)
        let userId = NSUserDefaults.standardUserDefaults().integerForKey("user_id")
        let fileName = "\(userId)_\(timestamp).jpg"
        let url = BaseApi.baseUrl + "/upload"
        Alamofire.upload(
            .POST,
            url,
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(data: imageData, name: "image", fileName: fileName, mimeType: "JPG")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        callback(fileName)
                        debugPrint(response)
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
        )
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

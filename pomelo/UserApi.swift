//
//  UserApi.swift
//  pomelo
//
//  Created by zhouqi on 16/1/9.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserApi: BaseApi {
    static let sharedInstance = UserApi()
    
    func getSelfProfile(callback: (User) -> Void) -> Void {
        self.get("/user", callback: { (json) -> Void in
            NSUserDefaults.standardUserDefaults().setObject(json["user_name"].string!, forKey: "user_name")
            NSUserDefaults.standardUserDefaults().setObject(json["user_avatar"].string, forKey: "user_avatar")
            User.me?.userName = json["user_name"].string!
            User.me?.userAvatar = json["user_avatar"].string
            }) { (JSON) -> Void in
                
        }
    }
    
    func getProfile(userId: Int, callback: (User) -> Void) -> Void {
        let url = UserApi.baseUrl + "/\(userId)"
        let request = Alamofire.request(.GET, url)
        request.responseJSON {
            response in
            if let value = response.result.value {
                print("JSON: \(value)")
            }
        }
    }
    
    func login(userName: String, password: String, callback:() -> Void, failedCallback: () -> Void) -> Void {
        self.post("/user/login", parameters: ["user_name": userName, "user_password": password], callback: { (json) -> Void in
            NSUserDefaults.standardUserDefaults().setInteger(json["user_id"].int!, forKey: "user_id")
            NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
            NSUserDefaults.standardUserDefaults().setObject(json["token"].string!, forKey: "token")
            NSUserDefaults.standardUserDefaults().synchronize()
            callback()
            }) { (json) -> Void in
                failedCallback()
        }
    }
    
    func register(userName: String, password: String, callback:() -> Void, failedCallback: () -> Void) -> Void {
        self.post("/user/register", parameters: ["user_name": userName, "user_password": password], callback: { (json) -> Void in
            NSUserDefaults.standardUserDefaults().setInteger(json["user_id"].int!, forKey: "user_id")
            NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
            NSUserDefaults.standardUserDefaults().setObject(json["token"].string!, forKey: "token")
            NSUserDefaults.standardUserDefaults().synchronize()
            callback()
            }) { (json) -> Void in
            failedCallback()
        }
    }
    
    func changeAvatar(userAvatar: String, callback:() -> Void, failedCallback: () -> Void) -> Void {
        self.post("/user", parameters: ["user_avatar": userAvatar], callback: { (json) -> Void in
            NSUserDefaults.standardUserDefaults().setObject(userAvatar, forKey: "user_avatar")
            User.me?.userAvatar = userAvatar
            callback()
            }) { (json) -> Void in
                failedCallback()
        }
    }
    
    

}

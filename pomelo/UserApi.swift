//
//  UserApi.swift
//  pomelo
//
//  Created by zhouqi on 16/1/9.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation
import Alamofire
//import SwiftyJSON

class UserApi: NSObject {
    static let sharedInstance = UserApi()
    func getSelfProfile(callback: (User) -> Void) -> Void {
        let url = "http://127.0.0.1:8100/pomelo/api/v1/user"
        let request = Alamofire.request(.GET, url)
        request.responseJSON {
            response in
            if let value = response.result.value {
//                let json = JSON(value)
//                callback(Item.load(json))
                print("JSON: \(value)")
            }
        }
    }
    
    func getProfile(userId: Int, callback: (User) -> Void) -> Void {
        let url = "http://127.0.0.1:8100/pomelo/api/v1/user/\(userId)"
        let request = Alamofire.request(.GET, url)
        request.responseJSON {
            response in
            if let value = response.result.value {
                print("JSON: \(value)")
            }
        }
    }

}

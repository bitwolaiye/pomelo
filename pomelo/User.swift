//
//  User.swift
//  pomelo
//
//  Created by zhouqi on 16/1/9.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation

class User: NSObject {
    static var me:User? = User.getSelfProfile()
    
    var userId:Int = 0
    var userName:String = ""
    var userAvatar:String?
    var userGender:Int = 0
    
    init(userId: Int, userName: String, userGender: Int, userAvatar: String?) {
        self.userId = userId
        self.userName = userName
        self.userGender = userGender
        self.userAvatar = userAvatar
    }
    
    static func getSelfProfile() -> User? {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if userDefault.objectForKey("token") != nil {
            let userId = userDefault.integerForKey("user_id")
            let userName:String = userDefault.objectForKey("user_name") as! String
            return User(userId: userId, userName: userName, userGender: 0, userAvatar: nil)
        } else {
            return nil
        }
    }
}

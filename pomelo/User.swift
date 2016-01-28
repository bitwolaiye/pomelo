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
    var userAvatar:String? {
        didSet {
            if userAvatar == nil {
                userAvatarUrl = nil
                userAvatarThumbUrl = nil
            } else {
                userAvatarUrl = "https://zhouqi.work/pomelo/avatar/\(userAvatar!)"
                userAvatarThumbUrl = "https://zhouqi.work/pomelo/avatar/thumb/\(userAvatar!)"
            }
        }
    }
    var userAvatarUrl:String?
    var userAvatarThumbUrl:String?
    var userGender:Int = 0
    
    
    init(userId: Int, userName: String, userGender: Int, userAvatar: String?) {
        self.userId = userId
        self.userName = userName
        self.userGender = userGender
        self.userAvatar = userAvatar
        if userAvatar == nil {
            userAvatarUrl = nil
        } else {
            userAvatarUrl = "https://zhouqi.work/pomelo/avatar/\(userAvatar!)"
            userAvatarThumbUrl = "https://zhouqi.work/pomelo/avatar/thumb/\(userAvatar!)"
        }

    }
    
    static func getSelfProfile() -> User? {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if userDefault.objectForKey("token") != nil {
            let userId = userDefault.integerForKey("user_id")
            let userName:String = userDefault.objectForKey("user_name") as! String
            let userAvatar:String? = userDefault.objectForKey("user_avatar") as? String
            return User(userId: userId, userName: userName, userGender: 0, userAvatar: userAvatar)
        } else {
            return nil
        }
    }
}

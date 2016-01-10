//
//  User.swift
//  pomelo
//
//  Created by zhouqi on 16/1/9.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation

class User: NSObject {
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
}

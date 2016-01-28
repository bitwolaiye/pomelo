//
//  Channel+Api.swift
//  pomelo
//
//  Created by zhouqi on 16/1/10.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftDate

extension Channel {
    static func load_array(array: Array<JSON>) -> [Channel] {
        var channels = [Channel]()
        for each:JSON in array {
            let user = User(userId: each["channel_user_id"].int!, userName: each["user_name"].string!, userGender: each["user_gender"].int!, userAvatar: each["user_avatar"].string)
            channels.append(Channel(channelId: each["channel_id"].int!, channelName: each["channel_name"].string!, channelOwnner: user))
        }
        return channels
    }
}


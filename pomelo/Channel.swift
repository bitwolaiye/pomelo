//
//  Channel.swift
//  pomelo
//
//  Created by zhouqi on 16/1/9.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation

class Channel: NSObject {
    var channelId:Int = 0
    var channelName:String = ""
    var channelOwnner:User?
    
    init(channelId: Int, channelName:String, channelOwnner:User?) {
        self.channelId = channelId
        self.channelName = channelName
        self.channelOwnner = channelOwnner
    }
}

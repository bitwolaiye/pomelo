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
    var channelAvatar:String? {
        didSet {
            self.updateUrl()
        }
    }
    var channelAvatarUrl:String?
    var channelAvatarThumbUrl:String?

    var channelOwnner:User?

    init(channelId: Int, channelName:String, channelAvatar:String?, channelOwnner:User?) {
        super.init()
        self.channelId = channelId
        self.channelName = channelName
        self.channelAvatar = channelAvatar
        self.channelOwnner = channelOwnner
        self.updateUrl()
    }
    
    func updateUrl() {
        if channelAvatar == nil {
            channelAvatarUrl = nil
            channelAvatarThumbUrl = nil
        } else {
            channelAvatarUrl = "https://zhouqi.work/pomelo/avatar/\(channelAvatar!)"
            channelAvatarThumbUrl = "https://zhouqi.work/pomelo/avatar/thumb/\(channelAvatar!)"
        }
    }
}

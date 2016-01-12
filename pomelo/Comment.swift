//
//  Comment.swift
//  pomelo
//
//  Created by zhouqi on 16/1/12.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation

class Comment: NSObject {
    var commentId:Int = 0
    var commentText:String = ""
    var commentPic:String?
    var commentVoice:String?
    var commentVideo:String?
    var commentTime:NSDate = NSDate(timeIntervalSince1970: 1)
    var user:User?
    
    init(commentId: Int, commentText: String, commentTime: NSDate, user: User?) {
        self.commentId = commentId
        self.commentText = commentText
        self.commentTime = commentTime
        self.user = user
    }
}

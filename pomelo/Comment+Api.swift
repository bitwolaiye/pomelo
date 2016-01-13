//
//  Comment+Api.swift
//  pomelo
//
//  Created by zhouqi on 16/1/13.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftDate

extension Comment {
    static func load_array(array: Array<JSON>) -> [Comment] {
        var comments = [Comment]()
        for each:JSON in array {
            let user = User(userId: each["user_id"].int!, userName: each["user_name"].string!, userGender: each["user_gender"].int!, userAvatar: nil)
            comments.append(Comment(commentId: each["comment_id"].int!, commentText: each["comment_text"].string!, commentTime: each["comment_time"].string!.toDate(DateFormat.ISO8601)!, user: user))
        }
        return comments
    }

}

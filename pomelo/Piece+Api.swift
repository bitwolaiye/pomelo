//
//  Piece+Api.swift
//  pomelo
//
//  Created by zhouqi on 16/1/10.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftDate

extension Piece {
    static func load_array(array: Array<JSON>) -> [Piece] {
        var pieces = [Piece]()
        for each:JSON in array {
            let user = User(userId: each["user_id"].int!, userName: each["user_name"].string!, userGender: each["user_gender"].int!, userAvatar: each["user_avatar"].string)
            pieces.append(Piece(pieceId: each["piece_id"].int!, pieceText: each["piece_text"].string!, pieceTime: each["piece_time"].string!.toDate(DateFormat.ISO8601)!, user: user, channel: nil))
        }
        return pieces
    }

}

//
//  Piece.swift
//  pomelo
//
//  Created by zhouqi on 16/1/9.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation

class Piece: NSObject {
    var pieceId:Int = 0
    var pieceText:String = ""
    var piecePic:String?
    var pieceVoice:String?
    var pieceVideo:String?
    var pieceTime:NSDate = NSDate(timeIntervalSince1970: 1)
    var user:User?
    var channel:Channel?
    
    init(pieceId: Int, pieceText: String, pieceTime: NSDate, user: User?, channel: Channel?) {
        self.pieceId = pieceId
        self.pieceText = pieceText
        self.pieceTime = pieceTime
        self.user = user
        self.channel = channel
    }
}

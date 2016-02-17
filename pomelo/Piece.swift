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
    var likeCnt:Int = 0
    var commentCnt:Int = 0
    var isLike:Int = 0
    var user:User?
    var channel:Channel?
    
    var piecePicUrl:String?
    var piecePicThumbUrl:String?
    
    init(pieceId: Int, pieceText: String, pieceTime: NSDate, piecePic: String?, likeCnt: Int, commentCnt: Int, isLike: Int, user: User?, channel: Channel?) {
        super.init()
        
        self.pieceId = pieceId
        self.pieceText = pieceText
        self.pieceTime = pieceTime
        self.piecePic = piecePic
        self.likeCnt = likeCnt
        self.commentCnt = commentCnt
        self.isLike = isLike
        
        self.user = user
        self.channel = channel
        
        self.updateUrl()
    }
    
    func updateUrl() -> Void {
        if piecePic == nil {
            piecePicUrl = nil
            piecePicThumbUrl = nil
        } else {
            piecePicUrl = "https://zhouqi.work/pomelo/piece/\(piecePic!)"
            piecePicThumbUrl = "https://zhouqi.work/pomelo/piece/thumb/\(piecePic!)"
        }
    }
    
    func changeLike() -> Int {
        if isLike == 1 {
            isLike = -1
            likeCnt -= 1
            if likeCnt < 0 {
                likeCnt = 0
            }
            return -1
        } else {
            isLike = 1
            likeCnt += 1
            return 1
        }
    }
}

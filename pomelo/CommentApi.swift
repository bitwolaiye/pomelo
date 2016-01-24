//
//  CommentApi.swift
//  pomelo
//
//  Created by zhouqi on 16/1/13.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CommentApi: BaseApi {
    static let sharedInstance = CommentApi()
    
    func getCommentList(pieceId: Int, callback: ([Comment]) -> Void) -> Void {
        let url = "/piece/\(pieceId)/comment/list"
        self.get(url, callback: { (json) -> Void in
            callback(Comment.load_array(json["list"].array!))
            }) { (json) -> Void in
                
        }
    }

    func addComment(pieceId: Int, commentText: String, callback: (Int) -> Void) -> Void {
        let url = "/piece/\(pieceId)/comment"
        self.post(url, parameters: ["piece_id": pieceId, "comment_text": commentText], callback: { (json) -> Void in
            callback(json["comment_id"].int!)
            }) { (json) -> Void in
                
        }
    }
}

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

class CommentApi: NSObject {
    static let sharedInstance = CommentApi()
    
    func getCommentList(pieceId: Int, callback: ([Comment]) -> Void) -> Void {
        let url = "http://127.0.0.1:8100/pomelo/api/v1/piece/\(pieceId)/comment/list"
        let request = Alamofire.request(.GET, url)
        request.responseJSON {
            response in
            if let value = response.result.value {
                let json = JSON(value)
                callback(Comment.load_array(json["list"].array!))
                print("JSON: \(value)")
            }
        }
    }

}

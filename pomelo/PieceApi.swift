//
//  PieceApi.swift
//  pomelo
//
//  Created by zhouqi on 16/1/9.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PieceApi: BaseApi {
    static let sharedInstance = PieceApi()
    
    func getChannelPieceList(chanelId:Int, callback: ([Piece]) -> Void) -> Void {
        
        let url = "/channel/\(chanelId)/piece/list"
        self.get(url, callback: { (json) -> Void in
            callback(Piece.load_array(json["list"].array!))
            }) { (json) -> Void in
                
        }
    }
    
    func addPiece(channelId: Int, pieceText: String, callback: (Int) -> Void) -> Void {
        let url = "/piece"
        self.post(url, parameters: ["channel_id": channelId, "piece_text": pieceText], callback: { (json) -> Void in
            callback(json["piece_id"].int!)
            }) { (json) -> Void in
                
        }
    }

}

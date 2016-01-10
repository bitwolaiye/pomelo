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

class PieceApi: NSObject {
    static let sharedInstance = PieceApi()
    
    func getChannelPieceList(chanelId:Int, callback: ([Piece]) -> Void) -> Void {
        let url = "http://127.0.0.1:8100/pomelo/api/v1/channel/\(chanelId)/piece/list"
        let request = Alamofire.request(.GET, url)
        request.responseJSON {
            response in
            if let value = response.result.value {
                let json = JSON(value)
                callback(Piece.load_array(json["list"].array!))
                print("JSON: \(value)")
            }
        }
    }

}

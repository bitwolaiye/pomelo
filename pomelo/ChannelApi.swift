//
//  ChannelApi.swift
//  pomelo
//
//  Created by zhouqi on 16/1/9.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ChannelApi: BaseApi {
    static let sharedInstance = ChannelApi()
    
    func getFavorChannelList(callback: ([Channel]) -> Void) -> Void {
        self.get("/channel", callback: { (json) -> Void in
            callback(Channel.load_array(json["list"].array!))
            }) { (json) -> Void in
                
        }
    }
    
    func getSuggestChannelList(callback: ([Channel]) -> Void) -> Void {
        self.get("/channel", callback: { (json) -> Void in
            callback(Channel.load_array(json["list"].array!))
            }) { (json) -> Void in
                
        }
    }
}

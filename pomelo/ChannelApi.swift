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

class ChannelApi: NSObject {
    static let sharedInstance = ChannelApi()
    func getFavorChannelList(callback: ([Channel]) -> Void) -> Void {
        let url = "http://127.0.0.1:8100/pomelo/api/v1/channel"
        let request = Alamofire.request(.GET, url)
        request.responseJSON {
            response in
            if let value = response.result.value {
                let json = JSON(value)
                callback(Channel.load_array(json["list"].array!))
                print("JSON: \(value)")
            }
        }
    }
    
    func getSuggestChannelList(callback: ([Channel]) -> Void) -> Void {
        let url = "http://127.0.0.1:8100/pomelo/api/v1/channel"
        let request = Alamofire.request(.GET, url)
        request.responseJSON {
            response in
            if let value = response.result.value {
                let json = JSON(value)
                callback(Channel.load_array(json["list"].array!))
                print("JSON: \(value)")
            }
        }
    }
}

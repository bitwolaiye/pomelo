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
//        NSTimeZone.systemTimeZone()
//        var df = DateFormat.ISO8601
        let myDateString = "2016-01-26 12:15:54 +0000"
        
        

        for each:JSON in array {
//            var t2 = df.dateFromString(each["piece_time"].string!)
            NSLocale.autoupdatingCurrentLocale()
            let user = User(userId: each["user_id"].int!, userName: each["user_name"].string!, userGender: each["user_gender"].int!, userAvatar: nil)
            pieces.append(Piece(pieceId: each["piece_id"].int!, pieceText: each["piece_text"].string!, pieceTime: each["piece_time"].string!.toDate(DateFormat.ISO8601)!, user: user, channel: nil))
        }
        return pieces
    }
    
    static func toDate(string:String) -> NSDate {
        let mydateFormatter = NSDateFormatter()
        mydateFormatter.calendar = NSCalendar(calendarIdentifier: "NSCalendarIdentifierISO8601")
        mydateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        mydateFormatter.locale = NSLocale.systemLocale()// NSLocale(localeIdentifier: "en_US_POSIX")
        return mydateFormatter.dateFromString(string)!
//        if let dateToBeSaved = mydateFormatter.dateFromString(myDateString) {
//            print(dateToBeSaved)   // "2015-09-04 22:15:54 +0000"
//        }
    }

}

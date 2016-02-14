//
//  UIColor+Style.swift
//  pomelo
//
//  Created by zhouqi on 16/2/2.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit

extension UIColor {
    static func nickNameColor() -> UIColor {
        return UIColor.getColor(165, green: 62, blue: 255)
    }
    
    static func pieceTextColor() -> UIColor {
        return UIColor.getColor(30, green: 30, blue: 30)
    }
    
    static func timeColor() -> UIColor {
        return UIColor.getColor(200, green: 200, blue: 200)
    }
    
    static func commentCntColor() -> UIColor {
        return UIColor.getColor(196, green: 141, blue: 255)
    }
    
    static func likeCntColor() -> UIColor {
        return commentCntColor()
    }
    
    static func commentTextColor() -> UIColor {
        return UIColor.getColor(160, green: 160, blue: 160)
    }
    
    static func likeTextColor() -> UIColor {
        return commentTextColor()
    }

    static func cellBorderColor() -> UIColor {
        return UIColor.getColor(200, green: 200, blue: 200)
    }
    
    static func cellBackgroundColor() -> UIColor {
        return UIColor.getColor(255, green: 255, blue: 255)
    }
    
    static func tableBackgroundColor() -> UIColor {
        return UIColor.getColor(239, green: 239, blue: 244)
    }
    
    static func avatarBackgroundColor() -> UIColor {
        return UIColor.getColor(242, green: 242, blue: 242)
    }
    
    static func textBackgroundColor() -> UIColor {
        return UIColor.getColor(240, green: 240, blue: 240)
    }
    
    static func textPlaceholderColor() -> UIColor {
        return UIColor.getColor(200, green: 200, blue: 200)
    }
    
    static func innerSperateColor() -> UIColor {
        return UIColor.getColor(240, green: 240, blue: 240)
    }
    
    static func commentSperateColor() -> UIColor {
        return UIColor.getColor(230, green: 230, blue: 230)
    }
    
    static func getColor(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(Double(red) / 255.0), green: CGFloat(Double(green) / 255.0), blue: CGFloat(Double(blue) / 255.0), alpha: 1.0)
    }
}

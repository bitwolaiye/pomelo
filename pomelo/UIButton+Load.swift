//
//  UIButton+Load.swift
//  pomelo
//
//  Created by zhouqi on 16/1/29.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit

extension UIButton {
    func load(url:String?) -> Void {
        if url != nil {
            let url2:String = url!
            let array = url2.characters.split{$0 == "/"}.map(String.init)
            let last = array.last!
            if ["pomelo_1", "pomelo_2", "pomelo_3"].contains(last) {
                self.setImage(UIImage(named: last), forState: UIControlState.Normal)
            } else {
                self.kf_setImageWithURL(NSURL(string: url2)!, forState: UIControlState.Normal)
            }
        } else {
            self.setImage(nil, forState: UIControlState.Normal)
        }
    }


}

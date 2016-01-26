//
//  AddPieceView.swift
//  pomelo
//
//  Created by zhouqi on 16/1/26.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import YYText

class AddPieceView: UIView {
    @IBOutlet weak var textView:YYTextView!
    @IBOutlet weak var button:UIButton!
    
    var channel:Channel!

    func initSubviews() {
        textView = {
            let textField = YYTextView()
            
            self.addSubview(textField)
            
            textField.backgroundColor = UIColor.grayColor()
            textField.snp_makeConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(self)
                make.height.equalTo(40)
                make.left.equalTo(0)
                make.right.equalTo(self).offset(-50)
            })
            
            return textField
        } ()
        
        button = {
            let button = UIButton(type: UIButtonType.System)
            
            self.addSubview(button)
            
            button.backgroundColor = UIColor.redColor()
            button.snp_makeConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(self)
                make.height.equalTo(40)
                make.left.equalTo(self.snp_right).offset(-50)
                make.right.equalTo(self).offset(0)
            })
            
            button.addTarget(self, action: "addPiece:", forControlEvents: UIControlEvents.TouchUpInside)
            
            return button
        } ()
    }
    
    @IBAction func addPiece(sender: AnyObject) {
        PieceApi.sharedInstance.addPiece(self.channel.channelId, pieceText: self.textView.text) { (pieceId) -> Void in
            
        }
    }
    
    

}

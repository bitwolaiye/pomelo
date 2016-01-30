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
    var callback:((Piece) -> Void)!

    func initSubviews() {
        let borderView:UIView = {
            let view = UIView()
            
            self.addSubview(view)
            view.backgroundColor = UIColor.grayColor()
            view.snp_makeConstraints(closure: { (make) -> Void in
                make.left.top.equalTo(0)
                make.right.equalTo(self)
                make.height.equalTo(1)
            })
            
            return view
        } ()
        
        textView = {
            let textField = YYTextView()
            
            self.addSubview(textField)
            textField.font = UIFont.systemFontOfSize(20)
//            textField.backgroundColor = UIColor.grayColor()
            textField.snp_makeConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(self)
                make.height.equalTo(40)
                make.left.equalTo(5)
                make.right.equalTo(self).offset(-55)
            })
            
            return textField
        } ()
        
        button = {
            let button = UIButton(type: UIButtonType.System)
            
            self.addSubview(button)
            
//            button.backgroundColor = UIColor.redColor()
            button.setTitle("发送", forState: UIControlState.Normal)
//            button.layer.borderColor = UIColor.blackColor().CGColor
//            button.layer.borderWidth = 1
            
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
        let piece = Piece(pieceId: -1, pieceText: self.textView.text!, pieceTime: NSDate(), user: User.me, channel: self.channel)
        PieceApi.sharedInstance.addPiece(self.channel.channelId, pieceText: self.textView.text!) { (pieceId) -> Void in
            piece.pieceId = pieceId
            if self.callback != nil {
                self.callback(piece)
            }
        }
        self.textView.text = nil
        self.endEditing(true)
    }
    
    

}

//
//  AddPieceView.swift
//  pomelo
//
//  Created by zhouqi on 16/1/26.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import YYText

class AddPieceView: UIView, YYTextViewDelegate {
    @IBOutlet weak var textView:YYTextView!
    @IBOutlet weak var button:UIButton!
    
    var channel:Channel!
    var callback:((Piece) -> Void)!

    func initSubviews() {
        let borderView:UIView = {
            let view = UIView()
            
            self.addSubview(view)
            view.backgroundColor = UIColor.cellBorderColor()
            view.snp_makeConstraints(closure: { (make) -> Void in
                make.left.top.equalTo(0)
                make.right.equalTo(self)
                make.height.equalTo(UIConstant.shadowHeight)
            })
            
            return view
        } ()
        
        textView = {
            let textField = YYTextView()
            
            self.addSubview(textField)
            textField.font = UIFont.systemFontOfSize(UIConstant.textViewFontSize)
            textField.delegate = self
            textField.backgroundColor = UIColor.textBackgroundColor()
            textField.placeholderText = "say something"
            textField.placeholderTextColor = UIColor.textPlaceholderColor()
            textField.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(self.snp_centerY)
                make.left.equalTo(UIConstant.textViewLeftMargin)
                make.top.equalTo(UIConstant.textViewTopMargin)
                make.right.equalTo(self).offset(-UIConstant.sendButtonWidth - UIConstant.textViewLeftMargin)
            })
            
            return textField
        } ()
        
        button = {
            let button = UIButton(type: UIButtonType.System)
            
            button.enabled = false
            button.setTitle("发送", forState: UIControlState.Normal)
            
            self.addSubview(button)
            button.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(self.snp_centerY)
                make.height.equalTo(40)
                make.width.equalTo(UIConstant.sendButtonWidth)
                make.right.equalTo(self).offset(0)
            })
            
            button.addTarget(self, action: "addPiece:", forControlEvents: UIControlEvents.TouchUpInside)
            
            return button
        } ()
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    @IBAction func addPiece(sender: AnyObject) {
        let piece = Piece(pieceId: -1, pieceText: self.textView.text!, pieceTime: NSDate(), likeCnt: 0, commentCnt: 0, user: User.me, channel: self.channel)
        PieceApi.sharedInstance.addPiece(self.channel.channelId, pieceText: self.textView.text!) { (pieceId) -> Void in
            piece.pieceId = pieceId
            if self.callback != nil {
                self.callback(piece)
            }
        }
        self.textView.text = nil
        self.endEditing(true)
    }
    
    
    func textViewDidEndEditing(textView: YYTextView!) {
        self.button.enabled = textView.text != nil && textView.text.characters.count > 0
    }
    
    func textViewDidChange(textView: YYTextView!) {
        self.button.enabled = textView.text != nil && textView.text.characters.count > 0
    }
}

//
//  AddCommentView.swift
//  pomelo
//
//  Created by zhouqi on 16/1/26.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import YYText

class AddCommentView: UIView, YYTextViewDelegate {
    @IBOutlet weak var textView:YYTextView!
    @IBOutlet weak var button:UIButton!
    
    var piece:Piece!
    var callback:((Comment) -> Void)!
    
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
            
            textField.font = UIFont.systemFontOfSize(UIConstant.textViewFontSize)
            textField.delegate = self
            textField.backgroundColor = UIColor.textBackgroundColor()
            textField.placeholderText = "say something"
            textField.placeholderTextColor = UIColor.textPlaceholderColor()
            
            self.addSubview(textField)
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
            button.setTitle("评论", forState: UIControlState.Normal)
            
            self.addSubview(button)
            button.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(self.snp_centerY)
                make.height.equalTo(40)
                make.width.equalTo(UIConstant.sendButtonWidth)
                make.right.equalTo(self).offset(0)
            })
            
            button.addTarget(self, action: "addComment:", forControlEvents: UIControlEvents.TouchUpInside)
            
            return button
            } ()
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    @IBAction func addComment(sender: AnyObject) {
        let comment = Comment(commentId: -1, commentText: self.textView.text!, commentTime: NSDate(), user: User.me)
        CommentApi.sharedInstance.addComment(self.piece.pieceId, commentText: self.textView.text!) { (commentId) -> Void in
            comment.commentId = commentId
            if self.callback != nil {
                self.callback(comment)
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

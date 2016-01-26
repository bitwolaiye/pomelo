//
//  AddCommentView.swift
//  pomelo
//
//  Created by zhouqi on 16/1/26.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import YYText

class AddCommentView: UIView {
    @IBOutlet weak var textView:YYTextView!
    @IBOutlet weak var button:UIButton!
    
    var piece:Piece!
    
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
            
            button.addTarget(self, action: "addComment:", forControlEvents: UIControlEvents.TouchUpInside)
            
            return button
            } ()
    }
    
    @IBAction func addComment(sender: AnyObject) {
        CommentApi.sharedInstance.addComment(self.piece.pieceId, commentText: self.textView.text) { (commentId) -> Void in
            
        }
    }

    
}

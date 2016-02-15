//
//  AddPieceView.swift
//  pomelo
//
//  Created by zhouqi on 16/1/26.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import YYText

class AddPieceView: UIView, YYTextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var textView:YYTextView!
    @IBOutlet weak var button:UIButton!
    @IBOutlet weak var picButton:UIButton!
    @IBOutlet weak var controller:UIViewController?
    
    let imagePicker = UIImagePickerController()
    var imageData:NSData?
    
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
        
        picButton = {
            let button = UIButton(type: UIButtonType.System)
            
            button.setTitle("图片", forState: UIControlState.Normal)
            
            self.addSubview(button)
            button.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(self.snp_centerY)
                make.height.equalTo(40)
                make.width.equalTo(UIConstant.sendButtonWidth)
                make.left.equalTo(UIConstant.textViewLeftMargin)
            })
            
            button.addTarget(self, action: "useCamera:", forControlEvents: UIControlEvents.TouchUpInside)
            
            return button
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
                make.left.equalTo(UIConstant.textViewLeftMargin * 3 + UIConstant.sendButtonWidth)
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
        if self.imageData != nil {
            let piece = Piece(pieceId: -1, pieceText: self.textView.text!, pieceTime: NSDate(), piecePic: nil, likeCnt: 0, commentCnt: 0, user: User.me, channel: self.channel)
            PieceApi.sharedInstance.addPiece(self.channel.channelId, pieceText: self.textView.text!, imageData: self.imageData!) { (pieceId) -> Void in
                piece.pieceId = pieceId
                if self.callback != nil {
                    self.callback(piece)
                }
            }
            self.textView.text = nil
            self.endEditing(true)
            
        } else {
            let piece = Piece(pieceId: -1, pieceText: self.textView.text!, pieceTime: NSDate(), piecePic: nil, likeCnt: 0, commentCnt: 0, user: User.me, channel: self.channel)
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
    
    @IBAction func selectImage(sender: AnyObject) {
        imagePicker.allowsEditing = false
        //        imagePicker.sourceType = .PhotoLibrary
        
        self.controller!.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func useCamera(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.Camera
                //                imagePicker.mediaTypes = [kUTTypeImage as NSString]
                imagePicker.allowsEditing = false
                
                self.controller!.presentViewController(imagePicker, animated: true,
                    completion: nil)
                //                newMedia = true
        }
    }
    
    
    func textViewDidEndEditing(textView: YYTextView!) {
        self.button.enabled = textView.text != nil && textView.text.characters.count > 0
    }
    
    func textViewDidChange(textView: YYTextView!) {
        self.button.enabled = textView.text != nil && textView.text.characters.count > 0
    }
}

extension AddPieceView {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.controller!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let imagePicked = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageExtenstion = info[UIImagePickerControllerReferenceURL]
        // imageExtenstion will be "asset.JPG"/"asset.JPEG"/"asset.PNG"
        // so we have to remove the asset. part
        let normalizedImage = imagePicked.normalizedImage()
        var imagePickedData : NSData = UIImageJPEGRepresentation(normalizedImage, 1)!
        if imageExtenstion?.string == "PNG" {
            imagePickedData = UIImagePNGRepresentation(imagePicked)!
        } else if imageExtenstion?.string == "JPG" || imageExtenstion?.string == "JPEG"  {
            imagePickedData = UIImageJPEGRepresentation(imagePicked, 1)!
        }
        self.imageData = imagePickedData
//        UserApi.sharedInstance.upload(imagePickedData) { (userAvatar) -> Void in
//            UserApi.sharedInstance.changeAvatar(userAvatar, callback: { () -> Void in
//                
//                }) { () -> Void in
//                    
//            }
//        }
        
        self.controller!.dismissViewControllerAnimated(true, completion: nil)
    }
}

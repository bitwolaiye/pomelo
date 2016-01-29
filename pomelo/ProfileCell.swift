//
//  ProfileCell.swift
//  pomelo
//
//  Created by zhouqi on 16/1/29.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userAvatarImgView:UIButton!
    var user:User? {
        didSet {
            if user != nil {
                self.userAvatarImgView.load(user?.userAvatarThumbUrl)
            }
        }
    }
    let imagePicker = UIImagePickerController()
    
    @IBAction func changeAvatar(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.Camera
                //                imagePicker.mediaTypes = [kUTTypeImage as NSString]
                imagePicker.allowsEditing = false

                self.window?.rootViewController!.presentViewController(imagePicker, animated: true, completion: nil)

//                self.presentViewController(imagePicker, animated: true,
//                    completion: nil)
                //                newMedia = true
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initSubViews()
    }
    
    func initSubViews() {
        self.userAvatarImgView = {
            let imageView = UIButton()
            
            self.contentView.addSubview(imageView)
            
            imageView.snp_makeConstraints(closure: { (make) -> Void in
                make.left.top.equalTo(10)
                make.width.height.equalTo(60)
            })
            
            imageView.backgroundColor = UIColor.grayColor()
            imageView.addTarget(self, action: Selector("changeAvatar:"), forControlEvents: UIControlEvents.TouchUpInside)
            
            return imageView
        } ()
        
        self.imagePicker.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ProfileCell {
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        self.window?.rootViewController!.dismissViewControllerAnimated(true, completion: nil)
//    }
    
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
        UserApi.sharedInstance.upload(imagePickedData) { (userAvatar) -> Void in
            UserApi.sharedInstance.changeAvatar(userAvatar, callback: { () -> Void in
                self.userAvatarImgView.load(self.user?.userAvatarThumbUrl)
                }) { () -> Void in
                    
            }
        }

        picker.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
}

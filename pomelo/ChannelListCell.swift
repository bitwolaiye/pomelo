//
//  ChannelListCell.swift
//  pomelo
//
//  Created by zhouqi on 16/1/10.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Toast_Swift

class ChannelListCell: UITableViewCell {
    @IBOutlet weak var channelNameLabel:UILabel!
    @IBOutlet weak var channelAvatarImage:UIImageView!
    var channel:Channel! {
        didSet {
            self.channelNameLabel.text = self.channel.channelName
        }
    }
    
    func showImage() {
        self.channelAvatarImage.load(self.channel.channelAvatarThumbUrl)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.channelAvatarImage = {
            let imageView = UIImageView()
            imageView.layer.cornerRadius = UIConstant.channelAvatarWidth / 2.0
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor.avatarBackgroundColor()

            self.addSubview(imageView)

            imageView.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(UIConstant.channelAvatarWidth)
                make.height.equalTo(UIConstant.channelAvatarHeight)
                
                make.left.equalTo(self).offset(UIConstant.leftMargin)
                make.top.equalTo(self.snp_top).offset(UIConstant.topMargin)
            })
            
            return imageView
            } ()
        self.channelNameLabel = {
            let label = UILabel()
            self.addSubview(label)
            label.font = UIFont.systemFontOfSize(UIConstant.channelNameFontSize)
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self.channelAvatarImage.snp_right).offset(UIConstant.innerMargin)
                make.centerY.equalTo(self.channelAvatarImage.snp_centerY)
                make.right.equalTo(self.contentView.snp_right).offset(-UIConstant.leftMargin)
            })
            return label
            } ()
        self.contentView.backgroundColor = UIColor.cellBackgroundColor()
//        self.contentView.layer.borderWidth = 0.5
//        self.contentView.layer.borderColor = UIColor.blackColor().CGColor
        
        let bottomBorder = UIView()
//        bottomBorder.frame = CGRectMake(0.0, self.contentView.frame.height - 1, self.contentView.frame.size.width, 1.0);
        bottomBorder.backgroundColor = UIColor.cellBorderColor()
        self.contentView.addSubview(bottomBorder)
        bottomBorder.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.right.equalTo(self.contentView)
            make.height.equalTo(1)
            make.top.equalTo(self.contentView.snp_bottom).offset(-1)
        }

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

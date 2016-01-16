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

class ChannelListCell: UITableViewCell {
    @IBOutlet weak var channelNameLabel:UILabel!
    @IBOutlet weak var channelAvatarImage:UIImageView!
    var channel:Channel!
    
    func showChannel() {
        self.channelNameLabel.text = self.channel.channelName
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.channelAvatarImage = {
            let imageView = UIImageView()
            self.addSubview(imageView)
            imageView.layer.borderColor = UIColor.blackColor().CGColor
            imageView.layer.borderWidth = 1
            imageView.layer.cornerRadius = 20
            imageView.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(40)
                make.height.equalTo(40)
                
                make.left.equalTo(self).offset(10)
                make.top.equalTo(self.snp_top).offset(10)
            })
            
            return imageView
            } ()
        self.channelNameLabel = {
            let label = UILabel()
            self.addSubview(label)
            label.font = UIFont.systemFontOfSize(14)
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self.channelAvatarImage.snp_right).offset(10)
                make.top.equalTo(self.snp_top).offset(10)
            })
            return label
            } ()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

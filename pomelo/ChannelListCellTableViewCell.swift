//
//  ChannelListCellTableViewCell.swift
//  pomelo
//
//  Created by zhouqi on 16/1/10.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ChannelListCellTableViewCell: UITableViewCell {
    @IBOutlet weak var channelNameLabel:UILabel!
//    @IBOutlet weak var itemNameLabel:UILabel!
//    @IBOutlet weak var itemBuyCntLabel:UILabel!
    var channel:Channel!
    
    func showChannel() {
        self.channelNameLabel.text = self.channel.channelName
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.channelNameLabel = {
            let label = UILabel()
            self.addSubview(label)
            label.font = UIFont.systemFontOfSize(14)
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self).offset(10)
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

//
//  CommentCell.swift
//  pomelo
//
//  Created by zhouqi on 16/1/10.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var commentTextLabel:UILabel!
    
    var comment:Comment! {
        didSet {
            self.commentTextLabel.text = comment.commentText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.commentTextLabel = {
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

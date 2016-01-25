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
    @IBOutlet weak var userNameLabel:UILabel!
    @IBOutlet weak var userAvatarImgView:UIImageView!
    @IBOutlet weak var commentTimeLabel:UILabel!
    
    var comment:Comment! {
        didSet {
            self.commentTextLabel.text = comment.commentText
            self.userNameLabel.text = comment.user!.userName
            self.commentTimeLabel.text = self.comment.commentTime.toRelativeString(abbreviated: false, maxUnits:2)
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
            let imageView = UIImageView()
            self.contentView.addSubview(imageView)
            imageView.layer.borderColor = UIColor.blackColor().CGColor
            imageView.layer.borderWidth = 1
            imageView.layer.cornerRadius = 20
            imageView.snp_makeConstraints { (make) -> Void in
                make.width.height.equalTo(40)
                make.left.equalTo(self.contentView).offset(10)
                make.top.equalTo(self.contentView).offset(10)
            }
            
            return imageView
            } ()
        
        self.userNameLabel = {
            let label = UILabel()
            
            self.contentView.addSubview(label)
            
            label.font = UIFont.systemFontOfSize(14)
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(userAvatarImgView.snp_right).offset(10)
                make.top.equalTo(self.contentView).offset(10)
            })
            
            return label
            } ()
        
        self.commentTimeLabel = {
            let label = UILabel()
            
            self.contentView.addSubview(label)
            
            label.font = UIFont.systemFontOfSize(14)
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self.contentView).offset(-10)
                make.top.equalTo(self.contentView).offset(10)
            })
            
            return label
            } ()
        
        self.commentTextLabel = {
            let label = UILabel()
            self.contentView.addSubview(label)
            label.font = UIFont.systemFontOfSize(14)
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self.userAvatarImgView.snp_right).offset(10)
                make.right.equalTo(self.contentView).offset(-10)
                make.top.equalTo(self.userNameLabel.snp_bottom).offset(10)
            })
            return label
            } ()
        
        self.contentView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(self.snp_width)
            make.bottom.greaterThanOrEqualTo(self.userAvatarImgView.snp_bottom).offset(10)
            make.bottom.greaterThanOrEqualTo(self.commentTextLabel.snp_bottom).offset(10)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

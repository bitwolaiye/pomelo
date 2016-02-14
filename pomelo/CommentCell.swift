//
//  CommentCell.swift
//  pomelo
//
//  Created by zhouqi on 16/1/10.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import DateTools

class CommentCell: UITableViewCell {
    @IBOutlet weak var commentTextLabel:UILabel!
    @IBOutlet weak var userNameLabel:UILabel!
    @IBOutlet weak var userAvatarImgView:UIImageView!
    @IBOutlet weak var commentTimeLabel:UILabel!
    
    var comment:Comment! {
        didSet {
            self.commentTextLabel.text = comment.commentText
            self.userNameLabel.text = comment.user!.userName
            self.commentTimeLabel.text = self.comment.commentTime.timeAgoSinceNow()
        }
    }
    
    func showImage() {
        if self.comment.user != nil && self.comment.user?.userAvatarUrl != nil {
            self.userAvatarImgView.kf_setImageWithURL(NSURL(string: (self.comment.user?.userAvatarThumbUrl)!)!)
        } else {
            self.userAvatarImgView.image = nil
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
            imageView.layer.cornerRadius = UIConstant.commentAvatarWidth / 2
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor.avatarBackgroundColor()
            
            imageView.snp_makeConstraints { (make) -> Void in
                make.width.height.equalTo(UIConstant.commentAvatarWidth)
                make.left.equalTo(self.contentView).offset(UIConstant.leftMargin)
                make.top.equalTo(self.contentView).offset(UIConstant.topMargin)
            }
            
            return imageView
            } ()
        
        self.userNameLabel = {
            let label = UILabel()
            
            self.contentView.addSubview(label)
            
            label.font = UIFont.systemFontOfSize(UIConstant.nickNameFontSize)
            label.textColor = UIColor.nickNameColor()
            
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(userAvatarImgView.snp_right).offset(UIConstant.innerMargin)
                make.top.equalTo(self.userAvatarImgView)
            })
            
            return label
            } ()
        
        self.commentTimeLabel = {
            let label = UILabel()
            
            self.contentView.addSubview(label)
            
            label.font = UIFont.systemFontOfSize(UIConstant.timeFontSize)
            label.textColor = UIColor.timeColor()
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self.contentView).offset(-UIConstant.leftMargin)
                make.top.equalTo(self.userAvatarImgView)
            })
            
            return label
            } ()
        
        self.commentTextLabel = {
            let label = UILabel()
            self.contentView.addSubview(label)
            label.font = UIFont.systemFontOfSize(UIConstant.pieceTextFontSize)
            label.textColor = UIColor.pieceTextColor()
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self.userAvatarImgView.snp_right).offset(UIConstant.innerMargin)
                make.right.equalTo(self.contentView).offset(-UIConstant.leftMargin)
                make.top.equalTo(self.userNameLabel.snp_bottom).offset(UIConstant.innerMargin)
            })
            return label
            } ()
        
        let separator:UIView = {
            let view = UIView()
            
            view.backgroundColor = UIColor.commentSperateColor()
            
            self.contentView.addSubview(view)
            view.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(commentTextLabel)
                make.right.equalTo(self.contentView)
                make.top.equalTo(self.contentView.snp_bottom)
                make.height.equalTo(UIConstant.shadowHeight)
            })
            
            return view
        } ()
        
        self.contentView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(self.snp_width)
            make.bottom.greaterThanOrEqualTo(self.userAvatarImgView.snp_bottom).offset(UIConstant.innerMargin)
            make.bottom.greaterThanOrEqualTo(self.commentTextLabel.snp_bottom).offset(UIConstant.innerMargin)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

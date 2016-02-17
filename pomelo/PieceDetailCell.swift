//
//  PieceDetailCell.swift
//  pomelo
//
//  Created by zhouqi on 16/1/12.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import DateTools
import SnapKit

class PieceDetailCell: UITableViewCell {
    @IBOutlet weak var pieceTextLabel:UILabel!
    @IBOutlet weak var userNameLabel:UILabel!
    @IBOutlet weak var userAvatarImgView:UIImageView!
    @IBOutlet weak var pieceTimeLabel:UILabel!
    @IBOutlet weak var piecePicImgView:UIImageView!
    @IBOutlet weak var likeCntLabel:UILabel!
    @IBOutlet weak var commentCntLabel:UILabel!
    @IBOutlet weak var likeBtn:UIButton!
    @IBOutlet weak var likeIconImgView:UIImageView!
    
    var piecePicImgViewHeightConstraint: Constraint!
    
    var piece:Piece! {
        didSet {
            self.pieceTextLabel.text = piece.pieceText
            self.userNameLabel.text = self.piece.user!.userName
//            self.pieceTimeLabel.text = self.piece.pieceTime.toRelativeString(abbreviated: false, maxUnits:2)
            self.pieceTimeLabel.text = self.piece.pieceTime.timeAgoSinceNow()
            self.likeCntLabel.text = "\(self.piece.likeCnt) Likes"
            self.commentCntLabel.text = "\(self.piece.commentCnt) Comments"

        }
    }
    
    func updateContent() {
        self.likeCntLabel.text = "\(self.piece.likeCnt) Likes"
        self.commentCntLabel.text = "\(self.piece.commentCnt) Comments"
        var like:String
        if self.piece.isLike == 1 {
            like = "liked"
        } else {
            like = "like"
        }
        self.likeIconImgView.image = UIImage(named: like)
    }
    
    func showImage() {
        if self.piece.user != nil && self.piece.user?.userAvatarUrl != nil {
            self.userAvatarImgView.kf_setImageWithURL(NSURL(string: (self.piece.user?.userAvatarThumbUrl)!)!)
        } else {
            self.userAvatarImgView.image = nil
        }
        var like:String
        if self.piece.isLike == 1 {
            like = "liked"
        } else {
            like = "like"
        }
        self.likeIconImgView.image = UIImage(named: like)

        if self.piece.piecePicUrl != nil {
            self.piecePicImgView.backgroundColor = UIColor.blackColor()
            self.piecePicImgView.kf_setImageWithURL(NSURL(string: (self.piece.piecePicUrl)!)!)
            self.piecePicImgViewHeightConstraint.uninstall()
            self.piecePicImgView.snp_makeConstraints(closure: { (make) -> Void in
                self.piecePicImgViewHeightConstraint = make.height.equalTo(self.piecePicImgView.snp_width).constraint
            })
        } else {
            self.piecePicImgView.image = nil
            self.piecePicImgViewHeightConstraint.uninstall()
            self.piecePicImgView.snp_updateConstraints(closure: { (make) -> Void in
                self.piecePicImgViewHeightConstraint = make.height.equalTo(0).constraint
            })
        }
        self.updateConstraintsIfNeeded()

    }
    
    @IBAction func like(sender: AnyObject) {
        let like = self.piece.changeLike()
        PieceApi.sharedInstance.like(self.piece.pieceId, status: like) { () -> Void in
            self.updateContent()
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
        let placeholder:UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.tableBackgroundColor()

            self.contentView.addSubview(view)
            view.snp_makeConstraints(closure: { (make) -> Void in
                make.left.top.equalTo(0)
                make.width.equalTo(self.contentView.snp_width)
                make.height.equalTo(UIConstant.pieceListMargin)
            })
            return view
        } ()

        self.userAvatarImgView = {
            let imageView = UIImageView()
            imageView.layer.cornerRadius = UIConstant.userAvatarWidth / 2
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor.avatarBackgroundColor()

            self.contentView.addSubview(imageView)
            imageView.snp_makeConstraints { (make) -> Void in
                make.width.height.equalTo(UIConstant.userAvatarWidth)
                make.left.equalTo(self.contentView).offset(UIConstant.leftMargin)
                make.top.equalTo(self.contentView).offset(UIConstant.innerMargin + UIConstant.pieceListMargin)
            }

            return imageView
        } ()

        self.userNameLabel = {
            let label = UILabel()
            label.font = UIFont.systemFontOfSize(UIConstant.nickNameFontSize)
            label.textColor = UIColor.nickNameColor()

            self.contentView.addSubview(label)
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(userAvatarImgView.snp_right).offset(UIConstant.innerMargin)
                make.centerY.equalTo(self.userAvatarImgView.snp_centerY)
                make.width.lessThanOrEqualTo(UIConstant.nickNameMaxWidth)
            })

            return label
        } ()

        self.pieceTimeLabel = {
            let label = UILabel()
            label.font = UIFont.systemFontOfSize(UIConstant.timeFontSize)
            label.textColor = UIColor.timeColor()

            self.contentView.addSubview(label)
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self.contentView.snp_right).offset(-UIConstant.leftMargin)
                make.centerY.equalTo(self.userAvatarImgView.snp_centerY)
                make.width.lessThanOrEqualTo(UIConstant.timeMaxWidth)
            })

            return label
        } ()

        self.pieceTextLabel = {
            let label = UILabel()

            label.font = UIFont.systemFontOfSize(UIConstant.pieceTextFontSize)
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByCharWrapping
            label.textColor = UIColor.pieceTextColor()

            self.contentView.addSubview(label)
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self.contentView).offset(UIConstant.pieceTextLeftMargin)
                make.right.equalTo(self.contentView).offset(-UIConstant.pieceTextLeftMargin)
                make.top.equalTo(self.userAvatarImgView.snp_bottom).offset(UIConstant.innerMargin * 2)
            })

            return label
        } ()

        piecePicImgView = {
            let imageView = UIImageView()
            
            self.contentView.addSubview(imageView)
            imageView.layer.cornerRadius = UIConstant.piecePicCorner
            imageView.clipsToBounds = true
            
            imageView.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self.contentView).offset(UIConstant.piecePicLeftMargin)
                self.piecePicImgViewHeightConstraint = make.height.equalTo(0).constraint
                make.centerX.equalTo(self.contentView.snp_centerX)
                make.top.equalTo(self.pieceTextLabel.snp_bottom).offset(UIConstant.innerMargin)
            })
            
            return imageView
            } ()


        let sperateView:UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.innerSperateColor()

            self.contentView.addSubview(view)
            view.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(UIConstant.shadowHeight)
                make.width.equalTo(self.contentView.snp_width)
                make.left.equalTo(0)
                make.top.equalTo(self.piecePicImgView.snp_bottom).offset(UIConstant.innerMargin)
            })

            return view
        } ()

        let staticStackView:UIStackView = {
            let stackView = UIStackView()

            self.contentView.addSubview(stackView)

            stackView.axis = UILayoutConstraintAxis.Horizontal
            stackView.alignment = UIStackViewAlignment.Center
            stackView.distribution = UIStackViewDistribution.FillEqually

            self.likeCntLabel = {
                let label = UILabel()

                stackView.addArrangedSubview(label)

                label.font = UIFont.systemFontOfSize(12)
                label.textAlignment = NSTextAlignment.Center
                label.snp_makeConstraints(closure: { (make) -> Void in
                    make.height.equalTo(stackView.snp_height)
                })

                return label
            } ()

            self.commentCntLabel = {
                let label = UILabel()

                stackView.addArrangedSubview(label)

                label.font = UIFont.systemFontOfSize(12)
                label.textAlignment = NSTextAlignment.Center
                label.snp_makeConstraints(closure: { (make) -> Void in
                    make.height.equalTo(stackView.snp_height)
                })

                return label
            } ()

            let view:UIView = {
                let view = UIView()

                stackView.addArrangedSubview(view)

                view.snp_makeConstraints(closure: { (make) -> Void in
                    make.height.equalTo(stackView.snp_height)
                })

                self.likeBtn = {
                    let button = UIButton()

                    view.addSubview(button)
                    button.addTarget(self, action: "like:", forControlEvents: UIControlEvents.TouchUpInside)
                    button.snp_makeConstraints(closure: { (make) -> Void in
                        make.center.equalTo(view.snp_center)
                    })

                    self.likeIconImgView = {
                        let imageView = UIImageView()

                        button.addSubview(imageView)
                        imageView.image = UIImage(named: "like")
                        imageView.snp_makeConstraints(closure: { (make) -> Void in
                            make.center.equalTo(button)
                            make.width.height.equalTo(30)
                        })

                        return imageView
                    } ()

                    return button
                } ()

                return view
            } ()

            stackView.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(self.contentView.snp_width)
                make.height.equalTo(48)
                make.left.equalTo(0)
                make.top.equalTo(sperateView.snp_bottom)
            })

            return stackView
        } ()
        
        let separator:SharpSeparatorView = {
            let separator = SharpSeparatorView()
            
            self.contentView.addSubview(separator)
            separator.backgroundColor = UIColor.whiteColor()
            separator.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(0)
                make.width.equalTo(self.contentView.snp_width)
                make.height.equalTo(7)
                make.top.equalTo(staticStackView.snp_bottom)
            })
            
            return separator
        } ()

        self.contentView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(self.snp_width)
            make.bottom.equalTo(staticStackView.snp_bottom)
        }

    }
    
//    override func awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
//        super.awakeAfterUsingCoder(aDecoder)
//        self.pieceTextLabel = {
//            let label = UILabel()
//            self.addSubview(label)
//            label.font = UIFont.systemFontOfSize(14)
//            label.snp_makeConstraints(closure: { (make) -> Void in
//                make.left.equalTo(self).offset(10)
//                make.top.equalTo(self.snp_top).offset(10)
//            })
//            return label
//            } ()
//        return self
//    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

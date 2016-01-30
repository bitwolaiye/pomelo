//
//  PieceListCell.swift
//  pomelo
//
//  Created by zhouqi on 16/1/10.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import SwiftDate
import DateTools
import Kingfisher

class PieceListCell: UITableViewCell {
    @IBOutlet weak var pieceTextLabel:UILabel!
    @IBOutlet weak var userNameLabel:UILabel!
    @IBOutlet weak var userAvatarImgView:UIImageView!
    @IBOutlet weak var pieceTimeLabel:UILabel!
    @IBOutlet weak var likeCntLabel:UILabel!
    @IBOutlet weak var commentCntLabel:UILabel!
    @IBOutlet weak var likeBtn:UIButton!
    
    
    var piece:Piece! {
        didSet {
            self.pieceTextLabel.text = self.piece.pieceText
            self.userNameLabel.text = self.piece.user!.userName
            self.pieceTimeLabel.text = self.piece.pieceTime.timeAgoSinceNow()
            self.likeCntLabel.text = "\(0) Likes"
            self.commentCntLabel.text = "\(0) Comments"
        }
    }
    
    func showImage() {
        if self.piece.user != nil && self.piece.user?.userAvatarUrl != nil {
            self.userAvatarImgView.kf_setImageWithURL(NSURL(string: (self.piece.user?.userAvatarThumbUrl)!)!)
        } else {
            self.userAvatarImgView.image = nil
        }
    }
    
    @IBAction func like(sender: AnyObject) {
        
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
        let pieceTextLabel = UILabel()
        self.contentView.addSubview(pieceTextLabel)
        self.pieceTextLabel = pieceTextLabel
        
        pieceTextLabel.font = UIFont.systemFontOfSize(14)
        pieceTextLabel.numberOfLines = 0
        pieceTextLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        pieceTextLabel.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView.snp_top).offset(10)
        })
        
        self.userAvatarImgView = {
            let imageView = UIImageView()
            self.contentView.addSubview(imageView)
            imageView.layer.borderColor = UIColor.blackColor().CGColor
            imageView.layer.borderWidth = 1
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            
            imageView.snp_makeConstraints { (make) -> Void in
                make.width.height.equalTo(40)
                make.left.equalTo(self.contentView.snp_left).offset(10)
                make.top.equalTo(self.pieceTextLabel.snp_bottom).offset(10)
            }
            
            return imageView
            } ()
        
        self.userNameLabel = {
            let label = UILabel()
            
            self.contentView.addSubview(label)
            
            label.font = UIFont.systemFontOfSize(14)
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(userAvatarImgView.snp_right).offset(10)
                make.top.equalTo(self.pieceTextLabel.snp_bottom).offset(10)
            })
            
            return label
            } ()
        
        self.pieceTimeLabel = {
            let label = UILabel()
            
            self.contentView.addSubview(label)
            
            label.font = UIFont.systemFontOfSize(14)
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self.contentView.snp_right).offset(-10)
                make.top.equalTo(self.pieceTextLabel.snp_bottom).offset(10)
            })
            
            return label
            } ()
        
        let sperateView:UIView = {
            let view = UIView()
            
            self.contentView.addSubview(view)
            
            view.backgroundColor = UIColor.grayColor()
            
            view.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(1)
                make.width.equalTo(self.contentView.snp_width)
                make.left.equalTo(0)
                make.top.equalTo(self.userAvatarImgView.snp_bottom).offset(10)
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
                //                label.backgroundColor = UIColor.brownColor()
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
                //                label.backgroundColor = UIColor.grayColor()
                label.snp_makeConstraints(closure: { (make) -> Void in
                    make.height.equalTo(stackView.snp_height)
                })
                
                return label
                } ()
            
            let view:UIView = {
                let view = UIView()
                
                stackView.addArrangedSubview(view)
                
                //                view.backgroundColor = UIColor.greenColor()
                
                view.snp_makeConstraints(closure: { (make) -> Void in
                    make.height.equalTo(stackView.snp_height)
                })
                
                self.likeBtn = {
                    let button = UIButton()
                    
                    view.addSubview(button)
                    button.addTarget(self, action: "like:", forControlEvents: UIControlEvents.TouchUpInside)
//                    button.backgroundColor = UIColor.redColor()
                    button.snp_makeConstraints(closure: { (make) -> Void in
                        make.center.equalTo(view.snp_center)
                    })
                    
                    var icon: UIImageView = {
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
                make.height.equalTo(50)
                make.left.equalTo(0)
                make.top.equalTo(self.userAvatarImgView.snp_bottom).offset(10)
            })
            
            return stackView
        } ()
        
        self.contentView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(self.snp_width)
            make.bottom.equalTo(staticStackView.snp_bottom).offset(10)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.backgroundColor = UIColor.whiteColor()
    }

}

//
//  PieceDetailCell.swift
//  pomelo
//
//  Created by zhouqi on 16/1/12.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit

class PieceDetailCell: UITableViewCell {
    @IBOutlet weak var pieceTextLabel:UILabel!
    
    var piece:Piece! {
        didSet {
            self.pieceTextLabel.text = piece.pieceText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.pieceTextLabel = {
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

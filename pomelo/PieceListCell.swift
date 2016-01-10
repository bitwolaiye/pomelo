//
//  PieceListCell.swift
//  pomelo
//
//  Created by zhouqi on 16/1/10.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit

class PieceListCell: UITableViewCell {
    @IBOutlet weak var PieceTextLabel:UILabel!
//    @IBOutlet weak var itemNameLabel:UILabel!
//    @IBOutlet weak var itemBuyCntLabel:UILabel!
    var piece:Piece!

    func showPiece() {
        self.PieceTextLabel.text = self.piece.pieceText
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let PieceTextLabel = UILabel()
        self.addSubview(PieceTextLabel)
        self.PieceTextLabel = PieceTextLabel
        
        PieceTextLabel.font = UIFont.systemFontOfSize(14)
        PieceTextLabel.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self.snp_top).offset(10)
        })
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  SharpSeparatorView.swift
//  pomelo
//
//  Created by zhouqi on 16/2/3.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit

class SharpSeparatorView: UIView {

    override func drawRect(rect: CGRect) {
        // Drawing code
        let half = (rect.width - rect.height) / 2
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(ctx, 200.0 / 255.0, 200.0 / 255.0, 200.0 / 255.0, 1.0)
        CGContextMoveToPoint(ctx, 0, rect.height)
        CGContextAddLineToPoint(ctx, half, rect.height)
        CGContextAddLineToPoint(ctx, half + rect.height, 0)
        CGContextAddLineToPoint(ctx, half + rect.height * 2, rect.height)
        CGContextAddLineToPoint(ctx, rect.width, rect.height)
        CGContextStrokePath(ctx)
    }

}

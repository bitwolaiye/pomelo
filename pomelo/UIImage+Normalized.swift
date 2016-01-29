//
//  UIImage+Normalized.swift
//  pomelo
//
//  Created by zhouqi on 16/1/29.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit

extension UIImage {
    func normalizedImage() -> UIImage {
        if self.imageOrientation == UIImageOrientation.Up {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.drawInRect(CGRectMake(0, 0, self.size.width, self.size.height))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}

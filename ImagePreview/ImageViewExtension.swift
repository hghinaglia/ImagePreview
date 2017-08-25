//
//  ImageViewExtension.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/25/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func scaledRect(finalRect: CGRect) {
        guard let image = image else { return }
        let newHeight = (finalRect.width / image.size.width) * image.size.height
        let newSize = CGSize(width: finalRect.width, height: newHeight)
        let newOrigin = CGPoint(x: 0, y: (finalRect.height - newSize.height) / 2.0)
        frame = CGRect(origin: newOrigin, size: newSize)
    }
    
}

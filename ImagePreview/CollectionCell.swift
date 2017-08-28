//
//  CollectionCell.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/28/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit


class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: ExpandableImageView!
    weak var presenter: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.delegate = self
    }
    
}

extension CollectionCell: ExpandableImageViewDelegate {
    
    func didTapImageView(_ imageView: ExpandableImageView) {
        TransitionManager.shared.presenter = presenter
        TransitionManager.shared.performTransition(with: imageView)
    }
    
}

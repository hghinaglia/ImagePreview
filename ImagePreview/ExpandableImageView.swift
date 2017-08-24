//
//  ExpandableImageView.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/24/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

protocol ExpandableImageViewDelegate: class {
    func didTapImageView(_ imageView: ExpandableImageView)
}

class ExpandableImageView: UIImageView {

    weak var delegate: ExpandableImageViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Actions
    
    func tap(_ sender: UIGestureRecognizer) {
        delegate?.didTapImageView(self)
    }
    
}

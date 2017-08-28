//
//  ExpandableImageView.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/24/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

protocol ExpandableImageViewDelegate: class {
    func didTap(imageView: ExpandableImageView)
}

extension ExpandableImageViewDelegate where Self: UIViewController {
    
    func didTap(imageView: ExpandableImageView) {
        TransitionManager.shared.performTransition(with: imageView, presenter: self)
    }
    
}

class ExpandableImageView: UIImageView {

    weak var delegate: ExpandableImageViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Actions
    
    func tap(_ sender: UIGestureRecognizer) {
        delegate?.didTap(imageView: self)
    }
    
}

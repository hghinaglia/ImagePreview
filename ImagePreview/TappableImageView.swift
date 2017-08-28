//
//  TappableImageView.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/24/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

protocol TappableImageViewDelegate: class {
    func didTap(imageView: TappableImageView)
}

extension TappableImageViewDelegate where Self: UIViewController {
    
    func didTap(imageView: TappableImageView) {
        TransitionManager.shared.performTransition(with: imageView, presenter: self)
    }
    
}

class TappableImageView: UIImageView {

    weak var delegate: TappableImageViewDelegate?
    
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

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

extension ExpandableImageViewDelegate where Self: UIViewController {
    
    func didTapImageView(_ imageView: ExpandableImageView) {
        transitionManager.setup(imageView: imageView)
        
        let imageViewerViewController = ImageViewerViewController(image: imageView.image!)
        imageViewerViewController.view.backgroundColor = .black
        imageViewerViewController.transitioningDelegate = transitionManager
        imageViewerViewController.modalPresentationStyle = .custom
        present(imageViewerViewController, animated: true, completion: nil)
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
        delegate?.didTapImageView(self)
    }
    
}

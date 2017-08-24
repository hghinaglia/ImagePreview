//
//  ViewController.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/24/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ExpandableImageViewDelegate {

    @IBOutlet weak var imageView1: ExpandableImageView!
    @IBOutlet weak var imageView2: ExpandableImageView!
    @IBOutlet weak var imageView3: ExpandableImageView!
    
    var isPresenting = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView1.delegate = self
        imageView2.delegate = self
        imageView3.delegate = self        
    }
    
    func didTapImageView(_ imageView: ExpandableImageView) {
        let transitionManager = TransitionManager(absoluteRect: imageView.convert(imageView.bounds, to: view),
                                                  image: imageView.image!)
        
        let expandablevc = DetailsViewController(image: imageView.image!)
        expandablevc.view.backgroundColor = .black
        expandablevc.transitioningDelegate = transitionManager
        expandablevc.modalPresentationStyle = .custom
        show(expandablevc, sender: nil)
    }
    
}


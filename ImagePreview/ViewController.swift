//
//  ViewController.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/24/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: ExpandableImageView!
    @IBOutlet weak var imageView2: ExpandableImageView!
    @IBOutlet weak var imageView3: ExpandableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView1.delegate = self
        imageView2.delegate = self
        imageView3.delegate = self
    }
    
}

extension ViewController: ExpandableImageViewDelegate {
    
    func didTapImageView(_ imageView: ExpandableImageView) {
        TransitionManager.shared.presenter = self
        TransitionManager.shared.performTransition(with: imageView)
    }
    
}

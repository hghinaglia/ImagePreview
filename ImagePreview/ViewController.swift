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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView1.delegate = self
        imageView2.delegate = self
        imageView3.delegate = self        
    }
    
    func didTapImageView(_ imageView: ExpandableImageView) {                
        transitionManager.setup(originalImageView: imageView, absoluteRect: imageView.convert(imageView.bounds, to: view))
                        
        let detailsViewController = DetailsViewController(image: imageView.image!)
        detailsViewController.view.backgroundColor = .black
        detailsViewController.transitioningDelegate = transitionManager
        detailsViewController.modalPresentationStyle = .custom
        present(detailsViewController, animated: true, completion: nil)
    }
    
}


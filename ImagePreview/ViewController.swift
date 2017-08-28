//
//  ViewController.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/24/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TappableImageViewDelegate {

    @IBOutlet weak var imageView1: TappableImageView!
    @IBOutlet weak var imageView2: TappableImageView!
    @IBOutlet weak var imageView3: TappableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView1.delegate = self
        imageView2.delegate = self
        imageView3.delegate = self
    }
    
}

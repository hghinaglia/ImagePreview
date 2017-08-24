//
//  DetailsViewController.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/24/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIScrollViewDelegate {

    weak var imageView: UIImageView!
    weak var scrollView: UIScrollView!
    
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.contentMode = .scaleAspectFit
        scrollView.maximumZoomScale = 1.8
        scrollView.minimumZoomScale = 1.0
        view.addSubview(scrollView)
        self.scrollView = scrollView
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        self.imageView = imageView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.frame
        scrollView.contentSize = imageView.frame.size
        
        let y = (view.frame.height - imageView.frame.height) / 2.0
        let origin = CGPoint(x: 0, y: y)
        imageView.frame = CGRect(origin: origin, size: CGSize(width: view.frame.width, height: 200))
        
    }
    
    // MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}

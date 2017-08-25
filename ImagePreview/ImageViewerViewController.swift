//
//  ImageViewerViewController.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/24/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

class ImageViewerViewController: UIViewController, UIScrollViewDelegate {

    weak var imageView: UIImageView!
    weak var scrollView: UIScrollView!
    weak var closeButton: UIButton!
    
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
        
        transitioningDelegate = TransitionManager.shared
        modalPresentationStyle = .custom
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 1.0
        view.addSubview(scrollView)
        self.scrollView = scrollView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleZoom))
        tapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(tapGesture)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.0
        imageView.scaledRect(finalRect: view.frame)
        scrollView.addSubview(imageView)
        self.imageView = imageView
        
        let closeButton = UIButton(type: .system)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.addSubview(closeButton)
        self.closeButton = closeButton
        
        prepareConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.imageView.alpha = 1.0
    }
    
    // MARK: - Actions
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
    
    func toggleZoom() {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
    // MARK: - Layouts
    
    func prepareConstraints() {
        
        let views: [String: Any] = [
            "scrollView": scrollView,
            "closeButton": closeButton
        ]
        
        let scrollViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: views)
        let scrollViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: views)
        view.addConstraints(scrollViewHorizontalConstraints + scrollViewVerticalConstraints)
        
        let closeButtonHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[closeButton]-|", options: [], metrics: nil, views: views)
        let closeButtonVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(20)-[closeButton]", options: [], metrics: nil, views: views)
        view.addConstraints(closeButtonHorizontalConstraints + closeButtonVerticalConstraints)
    }
    
    // MARK: - Helper
    
    func centeredFrameFor(scrollView: UIScrollView, view: UIView) -> CGRect {
        let boundsSize = scrollView.bounds.size
        var frameToCenter = view.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2.0
        } else {
            frameToCenter.origin.x = 0.0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2.0
        } else {
            frameToCenter.origin.y = 0.0
        }
        return frameToCenter
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        imageView.frame = centeredFrameFor(scrollView: scrollView, view: imageView)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}

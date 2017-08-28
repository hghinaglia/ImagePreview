//
//  TransitionManager.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/24/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

class TransitionManager: NSObject {
    
    static let shared = TransitionManager()
    
    enum TransitionType {
        case unwinding
        case presenting
    }
    
    fileprivate var type: TransitionType = .presenting
    fileprivate var sourceAbsoluteRect: CGRect!
    fileprivate var sourceImageView: UIImageView!
    fileprivate var sourceImageViewCopy: UIImageView!
    
    var detailImageView: UIImageView?
    
    func performTransition(with imageView: UIImageView, presenter: UIViewController) {
        guard let image = imageView.image else { return }
        
        // Source image view
        sourceImageView = imageView
        
        // Absolute rect base on screen
        sourceAbsoluteRect = imageView.convert(imageView.bounds, to: presenter.view)
        
        // Copy Image View
        sourceImageViewCopy = UIImageView(image: image)
        sourceImageViewCopy.frame = sourceAbsoluteRect
        sourceImageViewCopy.contentMode = sourceImageView.contentMode
        sourceImageViewCopy.layer.masksToBounds = sourceImageView.layer.masksToBounds
        sourceImageViewCopy.layer.cornerRadius = sourceImageView.layer.cornerRadius
        sourceImageViewCopy.clipsToBounds = sourceImageView.clipsToBounds
        
        // Prepare image viewer view controller
        let imageViewerViewController = ImageViewerViewController(image: image)
        imageViewerViewController.view.backgroundColor = .black
        imageViewerViewController.transitioningDelegate = self
        imageViewerViewController.modalPresentationStyle = .custom        
        presenter.present(imageViewerViewController, animated: true, completion: nil)
    }
    
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        
        switch type {
        case .presenting:
            guard let toController = transitionContext.viewController(forKey: .to) else { return }
            let finalFrame = transitionContext.finalFrame(for: toController)
            
            containerView.addSubview(toController.view)
            containerView.addSubview(sourceImageViewCopy)
            toController.view.alpha = 0.0
            sourceImageView.alpha = 0.0
            
            if sourceImageViewCopy.layer.cornerRadius > 0.0 {
                let animation = CABasicAnimation(keyPath: "cornerRadius")
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                animation.fromValue = sourceImageViewCopy.layer.cornerRadius
                animation.toValue = 0.0
                animation.duration = duration * 1.15
                sourceImageViewCopy.layer.add(animation, forKey: "cornerRadius")
            }
            
            UIView.animate(withDuration: duration, animations:  {
                self.sourceImageViewCopy.scaledRect(finalRect: finalFrame)                
                toController.view.alpha = 1
            }, completion: { finished in
                self.sourceImageViewCopy.alpha = 0.0
                transitionContext.completeTransition(finished)
            })
            
        case.unwinding:
            guard let fromController = transitionContext.viewController(forKey: .from) else { return }
            sourceImageViewCopy.frame = detailImageView?.frame ?? sourceImageViewCopy.frame
            sourceImageViewCopy.alpha = 1.0
            detailImageView?.alpha = 0.0
            containerView.insertSubview(fromController.view, belowSubview: sourceImageViewCopy)
            UIView.animate(withDuration: duration, animations:  {
                self.sourceImageViewCopy.frame = self.sourceAbsoluteRect
                fromController.view.alpha = 0.0
            }, completion: { finished in
                self.sourceImageView.alpha = 1.0
                self.sourceImageViewCopy.removeFromSuperview()
                transitionContext.completeTransition(finished)
            })
        }        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
}

extension TransitionManager: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        type = .presenting
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        type = .unwinding
        return self
    }
}

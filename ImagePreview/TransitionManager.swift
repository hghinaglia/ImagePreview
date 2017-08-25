//
//  TransitionManager.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/24/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

class TransitionManager: NSObject {
    
    enum TransitionType {
        case unwinding
        case presenting
    }
    
    fileprivate var type: TransitionType = .presenting
    fileprivate var absoluteRect: CGRect!
    fileprivate var originalImageView: UIImageView!
    fileprivate var duplicatedImageView: UIImageView!
    
    func setup(imageView: UIImageView) {
        originalImageView = imageView
        
        // Absolute rect base on screen
        absoluteRect = imageView.convert(
            imageView.bounds,
            to: UIApplication.shared.keyWindow!.rootViewController!.view!)
        
        // Copy Image View
        duplicatedImageView = UIImageView(image: originalImageView.image!)
        duplicatedImageView.frame = absoluteRect
        duplicatedImageView.contentMode = originalImageView.contentMode
        duplicatedImageView.layer.masksToBounds = originalImageView.layer.masksToBounds
        duplicatedImageView.layer.cornerRadius = originalImageView.layer.cornerRadius
    }
    
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromController = transitionContext.viewController(forKey: .from)
        let toController = transitionContext.viewController(forKey: .to)
        let finalFrame = transitionContext.finalFrame(for: toController!)
        let containerView = transitionContext.containerView
        
        switch type {
        case .presenting:
            
            let toView = toController!.view!
            containerView.addSubview(toView)
            containerView.addSubview(duplicatedImageView)
            toView.alpha = 0.0
            self.originalImageView.alpha = 0.0
            
            UIView.animate(withDuration: duration, animations:  {                
                self.duplicatedImageView.scaledRect(finalRect: finalFrame)
                toView.alpha = 1
            }, completion: { finished in
                self.duplicatedImageView.alpha = 0.0
                transitionContext.completeTransition(finished)
            })
            
        case.unwinding:
            
            let fromView = fromController!.view!
            fromView.alpha = 1.0
            self.duplicatedImageView.alpha = 1.0
            containerView.addSubview(fromView)
            UIView.animate(withDuration: duration, animations:  {
                self.duplicatedImageView.frame = self.absoluteRect
                fromView.alpha = 0.0
            }, completion: { finished in
                self.originalImageView.alpha = 1.0
                self.duplicatedImageView.removeFromSuperview()
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

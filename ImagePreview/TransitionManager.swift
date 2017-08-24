//
//  TransitionManager.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/24/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

class TransitionManager: NSObject {
    
    var originalAbsoluteRect: CGRect!
    var imageView: UIImageView!
    
    init(absoluteRect: CGRect, image: UIImage) {
        super.init()
        self.originalAbsoluteRect = absoluteRect
        self.imageView = UIImageView(image: image)
        self.imageView.frame = absoluteRect
    }
    
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let duration = transitionDuration(using: transitionContext)
        
        containerView.addSubview(imageView)
        containerView.addSubview(toView)
        
        toView.alpha = 0.0
        UIView.animate(withDuration: duration, animations:  {
        
            self.imageView.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - self.imageView.frame.height) / 2.0,
                                          width: UIScreen.main.bounds.width,
                                          height: 200)
            toView.alpha = 1.0
        }, completion: { finished in
            self.imageView.removeFromSuperview()
            transitionContext.completeTransition(finished)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
}

extension TransitionManager: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

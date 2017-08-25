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
    
    func setup(originalImageView: UIImageView, absoluteRect: CGRect) {
        self.absoluteRect = absoluteRect
        self.originalImageView = originalImageView
        
        duplicatedImageView = UIImageView(frame: absoluteRect)
        duplicatedImageView.contentMode = .scaleToFill
        duplicatedImageView.image = originalImageView.image!
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

extension UIView {
    
    func scaledRect(finalRect: CGRect) {
        let isHorizontal: Bool = frame.width >= frame.height
        
        if isHorizontal {
            let newHeight = (finalRect.width / frame.width) * frame.height
            let newSize = CGSize(width: finalRect.width, height: newHeight)
            let newOrigin = CGPoint(x: 0, y: (finalRect.height - newSize.height) / 2.0)
            frame = CGRect(origin: newOrigin, size: newSize)
            print("frame: \(frame)")
        } else {
            let newWidth = (frame.width * finalRect.height) / frame.height
            let newSize = CGSize(width: newWidth, height: finalRect.height)
            let newOrigin = CGPoint(x: (finalRect.width - newSize.width) / 2.0, y: 0)
            frame = CGRect(origin: newOrigin, size: newSize)
        }
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

//
//  ImageFrameTransitionAnimation.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 5/22/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

enum TransitionAnimatorState {
    case presenting
    case dismissing
}

protocol ImageFrameTransitionAnimationProtocol {
    var transitionSourceImageView : UIImageView { get }
}

class ImageFrameTransitionManager : NSObject, UIViewControllerTransitioningDelegate {
    fileprivate let transitionAnimator = ImageFrameTransitionAnimation()
    fileprivate let swipeInteractiveTransition = SwipeInteractiveTransition()
    
    func addSwipeInteractiveTransition(toController controller: UIViewController) {
        swipeInteractiveTransition.interact(withViewController: controller)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.state = .presenting
        transitionAnimator.sourceController = source
        return transitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.state = .dismissing
        return transitionAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractiveTransition.interactionInProgress ? swipeInteractiveTransition : nil
    }
}

class ImageFrameTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    var sourceController : UIViewController!
    var state : TransitionAnimatorState = TransitionAnimatorState.presenting
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromContoller = transitionContext.viewController(forKey: .from)!
        let toContoller = transitionContext.viewController(forKey: .to)!
        let duration = self.transitionDuration(using: transitionContext)
        let sourceController = (state == .presenting ? self.sourceController : fromContoller)!
        let destinationController = (state == .dismissing ? self.sourceController : toContoller)!
        let imageview = getSourceImage(fromController: sourceController)
        
        container.addSubview(toContoller.view)
        container.addSubview(fromContoller.view)
        container.addSubview(imageview)
        destinationController.view.layoutSubviews()
        
        toContoller.view.alpha = 1.0
        UIView.animate(withDuration: duration,
                       animations: {
                        fromContoller.view.alpha = 0.0
                        imageview.frame = self.getSourceImageFrame(fromController: destinationController)
        }) { (completed) in
            if !transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(true)
            }
            
            UIView.animate(withDuration: 0.2,
                           animations: {
                            imageview.alpha = 0.0
            }, completion: { (completed) in
                if (transitionContext.transitionWasCancelled) {
                    transitionContext.completeTransition(false)
                }
                
                imageview.removeFromSuperview()
            })
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}

fileprivate extension ImageFrameTransitionAnimation {
    func getSourceImage(fromController controller: UIViewController) -> UIImageView {
        guard let imageFrameProtocol = controller as? ImageFrameTransitionAnimationProtocol else {
            assertionFailure("Make sure the controllers implement the protocol to retreive the image")
            return UIImageView()
        }
        
        let sourceImage = imageFrameProtocol.transitionSourceImageView
        let image = UIImageView(image: sourceImage.image)
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true;
        image.cornerRadius = sourceImage.cornerRadius
        image.isUserInteractionEnabled = false;
        image.frame = getSourceImageFrame(fromController: controller)
        return image
    }
    
    func getSourceImageFrame(fromController controller: UIViewController) -> CGRect {
        guard let imageFrameProtocol = controller as? ImageFrameTransitionAnimationProtocol else {
            assertionFailure("Make sure the controllers implement the protocol to retreive the image")
            return CGRect.zero
        }
        
        let image = imageFrameProtocol.transitionSourceImageView
        
        if image.superview == controller.view {
            return image.frame
        }
        
        return controller.view.convert(image.frame, from: image.superview)
    }
}

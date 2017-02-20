//
//  SimpleTransitionAnimator.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/19/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class SwipeTransitionManager : NSObject {
    fileprivate let transitionAnimator = SwipeTransitionAnimator()
    fileprivate let swipeInteractiveTransition = SwipeInteractiveTransition()
    
    func addSwipeInteractiveTransition(toController controller: UIViewController) {
        swipeInteractiveTransition.interact(withViewController: controller)
    }
}

extension SwipeTransitionManager : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.direction = .right
        return transitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.direction = .left
        return transitionAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractiveTransition.interactionInProgress ? swipeInteractiveTransition : nil
    }
}

class SwipeTransitionAnimator: NSObject {
    enum Direction {
        case right, left
    }
    
    var direction = Direction.right
}

extension SwipeTransitionAnimator : UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        let duration = self.transitionDuration(using: transitionContext)
        
        toView.transform = direction == .right ? offScreenRight : offScreenLeft
        container.addSubview(toView)
        container.addSubview(fromView)
        UIView.animate(withDuration: duration,
                       delay: 0.0,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0.8,
                       options: .curveEaseInOut,
                       animations: {
                        fromView.transform = self.direction == .right ? offScreenLeft : offScreenRight
            toView.transform = .identity
        }) { completed in
            if (transitionContext.transitionWasCancelled) {
                container.addSubview(fromView)
                transitionContext.completeTransition(false)
            } else {
                transitionContext.completeTransition(true)
            }
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}

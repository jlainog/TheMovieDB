//
//  SwipeInteractionController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/20/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class SwipeInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false
    
    fileprivate let midProgressValue : CGFloat = 0.5
    fileprivate let translationCompleteProgress : CGFloat = 200
    fileprivate var shouldCompleteTransition = false
    fileprivate weak var viewController: UIViewController!
    
    func interact(withViewController viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(viewController.view)
    }
    
    fileprivate func prepareGestureRecognizerInView(_ view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        gesture.edges = UIRectEdge.left
        view.addGestureRecognizer(gesture)
    }
    
    func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        var progress = (translation.x / translationCompleteProgress)
        
        progress = min(max(progress, 0.0), 1.0)
        
        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
            
        case .changed:
            shouldCompleteTransition = progress > midProgressValue
            update(progress)
            
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        case .ended:
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                cancel()
            } else {
                finish()
            }
            
        default:
            print("Unsupported")
        }
    }

}

//
//  TransitionHandler.swift
//  contactsTest
//
//  Created by alexanderbollbach on 5/30/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit




let transitionDurationValue: NSTimeInterval = 2







// push

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
   func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
      return transitionDurationValue
   }
   
   func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
      
      // setup
      let mainVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)! as! MainController
      let stationVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)! as! PickStationViewController
      
      
      
      let mainView = mainVC.view
      let stationView = stationVC.view
      
      
      let frame = stationView!.frame
      
      
      
      let newRect = CGRect(x: frame.origin.x + (frame.size.width * 0.25), y: frame.origin.y, width: frame.size.width * 0.75, height: frame.size.height / 1.4)
      
      
      UIView.animateWithDuration(0.6, delay: 0.1, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
        
         stationView!.frame = newRect
         stationView.center = mainView.center
         
      }, completion: nil)
      
      
      
      
      
      
      let containerView = transitionContext.containerView()
      containerView!.insertSubview(stationVC.view, aboveSubview:mainView!)
      
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
      
   }
}





// pop

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
   func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
      return transitionDurationValue
   }
   
   func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
      
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
      
   }
}



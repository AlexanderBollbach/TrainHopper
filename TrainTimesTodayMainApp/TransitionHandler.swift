//
//  TransitionHandler.swift
//  contactsTest
//
//  Created by alexanderbollbach on 5/30/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit




let transitionDurationValue: TimeInterval = 0.8







// push

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return transitionDurationValue
   }
   
   
   
   
   
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
      
      
      
      // setup
      let mainVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)! as! MainController
      let stationVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as! PickStationViewController
      
      
      
      let mainView = mainVC.view
      let stationView = stationVC.view
      
      
      let frame = stationView!.frame
      
      
      
      
      
      
     
      
      
      let animation = CABasicAnimation(keyPath: "strokeEnd")
      animation.fromValue = 0.0
      animation.toValue = 1.0
      animation.duration = 2
      mainVC.activeButton?.outline.add(animation, forKey: nil)
      
      
//      
//      
//      let containerView = transitionContext.containerView()
//      containerView!.insertSubview(stationVC.view, aboveSubview:mainView!)
//      
//      
//      let newRect = CGRect(x: frame.origin.x + (frame.size.width * 0.25), y: frame.origin.y, width: frame.size.width * 0.75, height: frame.size.height / 1.4)
//      
//      UIView.animateWithDuration(transitionDuration(nil), delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
//        
//         mainView.alpha = 0.3
//         
//         stationView!.frame = newRect
//         stationView.center = mainView.center
//         
//         }, completion: { finished in
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
//      })
//      
//      
    
      
      
      
      
      
   }
}





// pop

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return transitionDurationValue
   }
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
      let mainVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as! MainController
      let stationVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)! as! PickStationViewController
      
      let mainView = mainVC.view
      let stationView = stationVC.view
      
      
      UIView.animate(withDuration: transitionDuration(using: nil)) { 
         mainView?.alpha = 1
      }
      
      UIView.animate(withDuration: transitionDuration(using: nil), delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
         
         
         
//         stationView.frame = CGRect(origin: stationView.frame.origin, size: CGSize(width: 0, height: 0))
         stationView!.alpha = 0
         

         
         }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
      
      
      
      
      
      
   }
}



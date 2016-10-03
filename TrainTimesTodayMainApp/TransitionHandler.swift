
import UIKit




let transitionDurationValue: TimeInterval = 0.3

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return transitionDurationValue
   }
   
   
   
   
   
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
      
      
      
      // setup
      
      let containerView = transitionContext.containerView

      
      let mainVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)! as! MainController
      let stationVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as! PickStationViewController
      
      let mainView = mainVC.view!
      let stationView = stationVC.view!
      
      
      
      
      
     
      
      
      

      
      
      
      
      
      CATransaction.begin()
      CATransaction.setCompletionBlock({
         
         
         containerView.insertSubview(stationView, aboveSubview:mainView)
         transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
      

      
      
//      
//      let activeButton = mainVC.activeButton!
//      
//      
//      activeButton.hideLayer()
//      
//      
//      mainVC.tempLayer = activeButton.getLayerCopy()
//      
//      
//      mainVC.view.layer.addSublayer(mainVC.tempLayer)
//      
//      
//      
//      let oldPathRect = mainVC.view.convert(activeButton.frame, to: mainVC.view)
//      
//      let startPath = UIBezierPath(roundedRect: oldPathRect, cornerRadius: 0).cgPath
//      let endPath = UIBezierPath(roundedRect: mainVC.view.frame, cornerRadius: 0).cgPath
//      
//      
//      let animation = CABasicAnimation(keyPath: "path")
//      animation.fromValue = startPath
//      animation.toValue = endPath
//      animation.duration = transitionDuration(using: transitionContext)
//      animation.isRemovedOnCompletion = false
//      animation.fillMode = kCAFillModeForwards
//      mainVC.tempLayer.add(animation, forKey: nil)
//      
//      
//      
//      
//      
//      
//      
//      
//
      
      CATransaction.commit()
      
      
      
      
      
      
   }
}


class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return transitionDurationValue
   }
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
//      let mainVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as! MainController

      
      let stationView = transitionContext.view(forKey: .from)
      stationView?.removeFromSuperview()
      
      
      
      
      CATransaction.begin()
      CATransaction.setCompletionBlock({

//         mainVC.tempLayer.removeFromSuperlayer()
         transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
      
      
//      
//      
//      
//      let startPath = UIBezierPath(roundedRect: mainVC.view.frame, cornerRadius: 0).cgPath
//      let endPath = UIBezierPath(roundedRect: mainVC.activeButton!.frame, cornerRadius: 0).cgPath
//      
//      
//      let animation = CABasicAnimation(keyPath: "path")
//      animation.fromValue = startPath
//      animation.toValue = endPath
//      animation.duration = transitionDuration(using: transitionContext)
//      animation.isRemovedOnCompletion = false
//      animation.fillMode = kCAFillModeForwards
//      mainVC.tempLayer.add(animation, forKey: nil)
//      
//      
//      
//      
      

      CATransaction.commit()
      
      
   }
}



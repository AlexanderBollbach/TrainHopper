//
//  ViewController.swift
//  TestAppExtension
//
//  Created by alexanderbollbach on 7/10/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit




class MainController: UIViewController {
   
   
   
   
   
   
   let dao = DAO.sharedInstance
   
   
   
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      dao.configureData()
      
      
   }
   
   

   
   
   
   
   
   
   
   
   
   
   
   // actions
   
   
   @IBAction func pickHomeStation(sender: UIButton) {
      
      let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      
      let vc = storyBoard.instantiateViewControllerWithIdentifier("PickStation") as! PickStationViewController
      
      vc.modalPresentationStyle = .OverCurrentContext
      
      vc.transitioningDelegate = self
      
      vc.stationList = dao.getStationList()
      
      self.presentViewController(vc, animated: true, completion: nil)
      
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
}








extension MainController: UIViewControllerTransitioningDelegate {
   
   
   func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) ->
      UIViewControllerAnimatedTransitioning? {
         
         let push = PushAnimator()
         return push
   }
   
   
   func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      
      let pop = PopAnimator()
      return pop
   }
   
   
}











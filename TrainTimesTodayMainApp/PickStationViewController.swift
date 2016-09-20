//
//  PickStationViewController.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 8/3/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit

class PickStationViewController: UIViewController {
   
   
   @IBOutlet weak var searchField: UISearchBar!
   var stationList: [String]?
   
   @IBOutlet weak var pickerView: UIPickerView!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      
      self.pickerView.reloadAllComponents()
      
      
   }
   
   
   
   
   @IBAction func tapped1(sender: AnyObject) {
      
      UIView.animateWithDuration(0.6, animations: {
      
         self.searchField.resignFirstResponder()
         
      }, completion: nil)
      
   }
   
   
}


extension PickStationViewController: UIViewControllerTransitioningDelegate {
   
   func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return PopAnimator()
   }
   
}







extension PickStationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
   
   
   
   
   func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
      return 1
   }
   func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return stationList?.count ?? 0
   }
   
   func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return stationList?[row]
   }
   
   
   
   
   func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
      
   }
   
   
   
   
}


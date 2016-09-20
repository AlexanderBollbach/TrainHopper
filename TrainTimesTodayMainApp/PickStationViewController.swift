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
   @IBOutlet weak var pickerView: UIPickerView!
   var stationList: [String]!
   
   var filteredStationList = [String]()
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      resetFilteredStationList()
      
      self.pickerView.reloadAllComponents()
      
      self.pickerView.selectRow(3, inComponent: 0, animated: true)
      
      
   }
   
   
   
   override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
      self.searchField.resignFirstResponder()
   }
   
   
   @IBAction func tapped1(sender: AnyObject) {
      
      UIView.animateWithDuration(0.6, animations: {
      
//         self.searchField.resignFirstResponder()
         
      }, completion: nil)
      
   }
   
   
   
   
   func resetFilteredStationList() {
      filteredStationList.removeAll()
      filteredStationList.appendContentsOf(stationList)
   }
   
   
}






extension PickStationViewController: UISearchBarDelegate {
   
   func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
      
      let temp = self.stationList?.filter{ $0.ABHasPrefix(searchText) }
      
      
      
      if searchText == "" {
         resetFilteredStationList()
         self.pickerView.reloadAllComponents()
         return
      }
      
      filteredStationList = temp!
      
      self.pickerView.reloadAllComponents()
      
   }
   
   func searchBarCancelButtonClicked(searchBar: UISearchBar) {
      resetFilteredStationList()
      self.pickerView.reloadAllComponents()
   }
   
   
   
   
   
   
}


extension String {
   
   func ABHasPrefix(searchTerm: String) -> Bool {
      
      let lowerSearch = searchTerm.lowercaseString
      
      let lowerSelf = self.lowercaseString
      
      if lowerSelf.hasPrefix(lowerSearch) {
         return true
      } else {
         return false
      }
      
   }
   
}


extension PickStationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
   
   
   func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return filteredStationList.count ?? 0
   }
   
   func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return filteredStationList[row]
   }
   
   
   
   
   func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
      
   }
   
   
   
   
}





extension PickStationViewController: UIViewControllerTransitioningDelegate {
   
   func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return PopAnimator()
   }
   
}




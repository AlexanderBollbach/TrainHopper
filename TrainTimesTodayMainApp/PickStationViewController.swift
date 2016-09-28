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
   
   var stationList: [String]!
   
   
   @IBOutlet weak var mainStackView: UIStackView!
   
   var filteredStationList = [String]()
   
   var stationToPick: SelectedStationModel!
   
   @IBOutlet weak var tableview: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      
      resetFilteredStationList()
      
      self.searchField.backgroundColor = UIColor.clear
      self.searchField.backgroundImage = UIImage()
      
      //      self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "stationCell")
      
      
      //      scrollToSelectedStation()
      
      
      
   }
   
   
   
   override func viewDidLayoutSubviews() {
      updateCellStyles()
   }
   
   
   
   
   
   func scrollToSelectedStation() {
      
      
      let index = indexOfCurrentStation()
      let indexPath = IndexPath(row: index, section: 0)
      self.tableview.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
      
      
      
      
   }
   
   
   func indexOfCurrentStation() -> Int {
      
      let idx = filteredStationList.index(of: stationToPick.stationName)!
      
      return idx
      
   }
   
   
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.searchField.resignFirstResponder()
   }
   
   
   
   func resetFilteredStationList() {
      filteredStationList.removeAll()
      filteredStationList.append(contentsOf: stationList)
   }
   
   
   
   @IBAction func tappedCancel(sender: AnyObject) {
      
      self.dismiss(animated: true, completion: nil)
   }
   
   
   
   
   
   func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
      
      let temp = self.stationList?.filter{ $0.ABHasPrefix(searchTerm: searchText) }
      
      if searchText == "" {
         resetFilteredStationList()
         self.tableview.reloadData()
         return
      }
      
      filteredStationList = temp!
      
      self.tableview.reloadData()
      
   }
   
   func searchBarCancelButtonClicked(searchBar: UISearchBar) {
      resetFilteredStationList()
      self.tableview.reloadData()
   }
   
   
   
   
   
}


// handles tableviewcell dynamics styling

extension PickStationViewController {
   
   
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      updateCellStyles()
   }
   
   func updateCellStyles() {
      
      
      
      let cells = self.tableview.visibleCells as! [StationCell]
      
      let maxHeight = self.view.frame.size.height
      
      for cell in cells {
         
         let indexpath = self.tableview.indexPath(for: cell)!
         let rect = self.tableview.rectForRow(at: indexpath)
         let rectOfCellInSuperview: CGRect = self.tableview.convert(rect, to: self.view)
         let heightInMainView = rectOfCellInSuperview.origin.y
         
         
         var mappedVal: Float!
         
         
         
         if heightInMainView < maxHeight / 2 {
            mappedVal = mapToRange(input: Float(heightInMainView), outputStart: 0, outputEnd: 1, inputStart: 0, inputEnd: Float(self.view.frame.size.height / 2), descending: false)
         } else {
            mappedVal = mapToRange(input: Float(heightInMainView), outputStart: 0, outputEnd: 1, inputStart: Float(self.view.frame.size.height / 2), inputEnd: Float(self.view.frame.size.height), descending: true)
         }

         cell.alpha = CGFloat(mappedVal)
         
         cell.leftConstraint.constant = CGFloat(mappedVal * 100)
         
         cell.stationName.font = UIFont(name: "Helvetica Neue", size: CGFloat(mappedVal * 30.0))
  
         
      }

   }
   
   


   func mapToRange(input: Float,  outputStart: Float, outputEnd: Float, inputStart: Float, inputEnd: Float, descending: Bool) -> Float {
 
      let outputDelta = outputEnd - outputStart
      let inputDelta = inputEnd - inputStart
      
      let slope = outputDelta / inputDelta
     
      var output = outputStart + (slope * (input - inputStart))
      
      if descending {
         output = outputEnd - output
      }
      
      return output
      
   }
   
   
}






extension PickStationViewController: UITableViewDelegate, UITableViewDataSource {
   
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return filteredStationList.count // ?? 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell: StationCell = self.tableview.dequeueReusableCell(withIdentifier: "stationCell")! as! StationCell
      
      cell.stationName.text = filteredStationList[indexPath.row]
      
      return cell
      
   }
   
   
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      stationToPick.stationName = filteredStationList[indexPath.row]
      
      let presentingVC = self.presentingViewController as! MainController
      
      presentingVC.updateStationButtons()
      
      self.presentingViewController?.dismiss(animated: true, completion: nil)
   }
   
   

   
   
}









extension PickStationViewController: UIViewControllerTransitioningDelegate {
   
   func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return PopAnimator()
   }
   
}








extension String {
   
   func ABHasPrefix(searchTerm: String) -> Bool {
      
      let lowerSearch = searchTerm.lowercased()
      let lowerSelf = self.lowercased()
      
      if lowerSelf.hasPrefix(lowerSearch) {
         return true
      } else {
         return false
      }
   }
}



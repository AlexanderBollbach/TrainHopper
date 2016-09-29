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
   
   var stationList: [StationModel]!
   
   
   
   var filteredStationList = [StationModel]()
   
   var stationToPick: StationModel!
   
   @IBOutlet weak var tableview: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      
      resetFilteredStationList()
      
      //      self.searchField.backgroundColor = UIColor.clear
      //      self.searchField.backgroundImage = UIImage()
      
      
   }
   
   
   
   override func viewDidLayoutSubviews() {
      updateCellStyles()
      
      
      
      resizeSearchField()
   }
   
   
   func resizeSearchField() {
      
      for subView1 in self.searchField.subviews as [UIView]  {
         
         for subView in subView1.subviews {
            if let textField = subView as? UITextField {
               var bounds: CGRect
               bounds = textField.frame
               bounds.size.height = self.searchField.frame.size.height
               textField.frame = bounds
               //               textField.borderStyle = UITextBorderStyle.RoundedRect
               
               
            }
         }
         
      }
      
      
   }
   
   
   
   
   
   func scrollToStation(station: StationModel) {
      
      
      let idx = stationList.index(of: station)!
      let indexPath = IndexPath(row: idx, section: 0)
      self.tableview.scrollToRow(at: indexPath, at: .middle, animated: true)
      
   }
   
   
   
   
   
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.searchField.resignFirstResponder()
   }
   
   
   
   func resetFilteredStationList() {
      filteredStationList.removeAll()
      filteredStationList.append(contentsOf: stationList)
   }
   
   
   
   
   
   
   
   
   
   
   
   
}




extension PickStationViewController: UISearchBarDelegate {
   
   
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
      let temp = self.stationList.filter{ $0.name.ABHasPrefix(searchTerm: searchText) }
      
      if temp.count >= 0 {
         scrollToStation(station: temp[0])
      }
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
         
         
         
         let offsetFromCenter = (maxHeight / 5)
         let mid = maxHeight / 2
         
         let lowerBound = mid - offsetFromCenter
         let upperBound = mid + offsetFromCenter
         
         if (heightInMainView < lowerBound) {
            
            mappedVal = mapToRange(input: Float(heightInMainView),
                                   outputStart: 0,
                                   outputEnd: 1,
                                   inputStart: 0,
                                   inputEnd: Float(lowerBound),
                                   descending: false)
            
         } else if (heightInMainView > upperBound) {
            
            mappedVal = mapToRange(input: Float(heightInMainView), outputStart: 0,
                                   outputEnd: 1,
                                   inputStart: Float(upperBound),
                                   inputEnd: Float(maxHeight),
                                   descending: true)
         } else {
            mappedVal = 1
         }
         
         
         if mappedVal < 0.5 {
            cell.alpha = CGFloat(mappedVal - 0.14)
         } else {
            cell.alpha = CGFloat(mappedVal)
         }
         
         
         cell.leftConstraint.constant = CGFloat(mappedVal * 150) - 150
         
         
         cell.stationName.font = UIFont.systemFont(ofSize: CGFloat(1 * 20))
         
         
         
      }
      
   }
   
   
   
   
   func mapToRange(input: Float,  outputStart: Float, outputEnd: Float, inputStart: Float, inputEnd: Float, descending: Bool) -> Float {
      
      let outputDelta = outputEnd - outputStart
      let inputDelta = inputEnd - inputStart
      
      let slope = outputDelta / inputDelta
      let inputOffset = input - inputStart
      
      var output = outputStart + (slope * inputOffset)
      
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
      
      cell.stationName.text = filteredStationList[indexPath.row].name
      
      return cell
      
   }
   
   
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      
      let newStation = filteredStationList[indexPath.row]
      stationToPick.name = newStation.name
      stationToPick.abbr = newStation.abbr
      stationToPick.lat = newStation.lat
      stationToPick.long = newStation.long
      
      let presentingVC = self.presentingViewController as! MainController
      
      presentingVC.updateStationButtons()
      
      self.presentingViewController?.dismiss(animated: true, completion: nil)
   }
   
   
   
   
   
}









//extension PickStationViewController: UIViewControllerTransitioningDelegate {
//
//   func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//      return PopAnimator()
//   }
//
//}








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





//
//
//
//
//

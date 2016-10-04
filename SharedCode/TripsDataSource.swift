
import UIKit


public class TripsDataSource: NSObject, UITableViewDataSource {
   
   
   public var dataStore: [TripModel]!
   
   
   public override convenience init() {
      
      let trips = [TripModel]()
      self.init(withTrips: trips)
   }
   
   public init(withTrips trips: [TripModel]) {
      
      self.dataStore = trips
      
   }

   
   public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataStore.count
   }
   

   
   
   
   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      
      let trip = dataStore[indexPath.row]
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "TripsCell", for: indexPath) as! TripsCell
      
      
      cell.departingLabel.text = trip.departing
      cell.arrivingLabel.text = trip.arriving
      
      return cell
   }

}

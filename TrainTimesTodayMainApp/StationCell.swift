//
//  StationCell.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 9/27/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit

class StationCell: UITableViewCell {

   @IBOutlet weak var stationName: UILabel!
   
   @IBOutlet weak var leftConstraint: NSLayoutConstraint!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

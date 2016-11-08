//
//  ABSimpleButton.swift
//  TrainTrackerLI
//
//  Created by alexanderbollbach on 10/15/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation
import SimpleButton

@IBDesignable


class ABSimpleButton: SimpleButton {
   override func configureButtonStyles() {
      
      
      super.configureButtonStyles()
      
      
      
      titleLabel?.numberOfLines = 0
      
      
      setTitleColor(UIColor.alizarinColor(), for: .normal)
      setTitleColor(UIColor.pomergranateColor(), for: .highlighted)
      setBorderWidth(6.0, for: .normal)
      setBorderColor(UIColor.alizarinColor(), for: .normal, animationDuration: 0.3)
      setBorderColor(UIColor.pomergranateColor(), for: .highlighted, animated: false)
      setTitle("BORDER COLOR", for: .normal)
   }
}

//
//  ParkingCell.swift
//  ParkingUW
//
//  Created by iGuest on 12/10/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class ParkingCell: UITableViewCell {
    @IBOutlet weak var garageName: UILabel!
    @IBOutlet weak var openSpot: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

//
//  EventCell.swift
//  ParkingUW
//
//  Created by Marco Cheng on 12/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var EventName: UILabel!
    @IBOutlet weak var EventRestriction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ParkingDetailsViewController.swift
//  ParkingUW
//
//  Created by iGuest on 12/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ParkingDetailsViewController: UIViewController {

    @IBOutlet weak var GarageName: UILabel!
    @IBOutlet weak var openSpot: UILabel!
    @IBOutlet weak var totalSpot: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    
    
    var data = [PFObject]()
    var eventData = [PFObject]()
    var array = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(array)
        GarageName.text = array[0] as? String
        openSpot.text = array[2] as? String
        totalSpot.text = array[3] as? String
        rate.text = array[4] as? String
        address.text = array[5] as? String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let view = segue.destinationViewController as! ParkingViewController
        view.data = self.data
        view.eventData = self.eventData
        
        
    }
    

}

//
//  EventDetailsViewController.swift
//  ParkingUW
//
//  Created by Marco Cheng on 12/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class EventDetailsViewController: UIViewController{

    @IBOutlet weak var restriction: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var EventTitle: UILabel!
    
    var data = [PFObject]()
    var eventData = [PFObject]()
    var index = 0
    
    
    var array = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        Description.text = array[1] as? String
        date.text = array[2] as? String
        restriction.text = array [3] as? String
        EventTitle.text = array[0] as? String
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
            let view = segue.destinationViewController as! EventViewController
            view.data = self.data
            view.eventData = self.eventData
        
        
    }


}

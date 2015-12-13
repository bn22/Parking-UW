//
//  EventViewController.swift
//  ParkingUW
//
//  Created by iGuest on 12/10/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var EventTableView: UITableView!
    var data = [PFObject]()
    var eventData = [PFObject]()
    var indexRow = 0
    
   var array = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = NSUserDefaults.standardUserDefaults()
        //eventData = defaults.arrayForKey("eventData") as! [NSMutableArray]
        EventTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.EventTableView.delegate = self
        self.EventTableView.dataSource = self
        EventTableView.reloadData()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as! EventCell
        let eventInfo = self.eventData[indexPath.row]
        cell.EventName.text = eventInfo["Event_Name"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventData.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //NSLog("you selected \(indexPath.row)")
        let event = self.eventData[indexPath.row]
        let event_name = event["Event_Name"] as! String
        let desc = event["Description"] as! String
        let date = event["Date"] as! String
        let restriction = event["Restriction"] as! String
        array = [event_name,desc,date,restriction]
       
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "eventDetail"){
            let view = segue.destinationViewController as! EventDetailsViewController
            view.data = self.data
            view.eventData = self.eventData
            view.array = self.array
            
            //view.index = 1
           
            
        }else if (segue.identifier == "backParking"){
            let view = segue.destinationViewController as! ParkingViewController
            view.data = self.data
            view.eventData = self.eventData
        }
    }
}

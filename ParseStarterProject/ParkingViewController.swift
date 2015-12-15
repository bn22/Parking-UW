//
//  ParkingViewController.swift
//  ParkingUW
//
//  Created by iGuest on 12/10/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ParkingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ParkingTable: UITableView!
    var eventData = [PFObject]()
    var data = [PFObject]()
    var array = []
    var query = PFQuery(className:"Garage_Info")
    var dateShow = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = NSUserDefaults.standardUserDefaults()
        //eventData = defaults.arrayForKey("eventData") as! [NSMutableArray]
        ParkingTable.reloadData()
        // Do any additional setup after loading the view.

    }
    
    override func viewDidAppear(animated: Bool) {
        if (!dateShow) {
            let date = NSDate()
            let unitFlags: NSCalendarUnit = [.Hour, .Day, .Month, .Year]
            let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: date)
            let month = components.month
            let day = components.day
            for (var i = 0; i < self.eventData.count; i++) {
                let temp = self.eventData[i]
                let eventDay = temp["Day"] as? Int
                let eventMonth = temp["Month"] as? Int
                if (day == eventDay && month == eventMonth) {
                    let eventName = temp["Event_Name"] as? String
                    let alert = UIAlertController(title: "Alert", message: "Today is \(eventName!)", preferredStyle: UIAlertControllerStyle.Alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    alert.addAction(ok);
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.ParkingTable.delegate = self
        self.ParkingTable.dataSource = self
        ParkingTable.reloadData()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ParkingCell") as! ParkingCell
        let garageInfo = self.data[indexPath.row]
        let currentUser = PFUser.currentUser()
        let parked = currentUser!["garage_name"] as? String
        let garageName = garageInfo["garage_name"] as? String
        
        cell.garageName.text = garageInfo["garageName"] as? String
    
        cell.openSpot.text = String(garageInfo["openSpots"])
        let spots = garageInfo["openSpots"] as? Int
        if (spots ==  0) {
            cell.openSpot.textColor = UIColor.redColor()
        } else {
            cell.openSpot.textColor = UIColor.greenColor()
        }
        
        if (parked == garageName) {
            cell.openSpot.textColor = UIColor.blueColor()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //NSLog("you selected \(indexPath.row)")
        
        let garage = self.data[indexPath.row]
        let garage_name = garage["garageName"] as! String
        let serial = garage["garage_name"] as! String
        let openSpot = String(garage["openSpots"])
        let totalSpot = String(garage["totalSpots"])
        let rate = garage["Rate"] as! String
        let address = garage["address"] as! String
        let latitude = garage["Latitude"] as! Double
        let longitude =  garage["Longitude"] as! Double
        array = [garage_name, serial, openSpot, totalSpot, rate, address, latitude, longitude]
        performSegueWithIdentifier("parkingDetail", sender: self)
    }

    @IBAction func update(sender: AnyObject) {
        query.whereKey("garageName", notEqualTo:"")
        query.orderByDescending("openSpots")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) garages.")
                // Do something with the found objects
                if let objects = objects {
                    //let defaults = NSUserDefaults.standardUserDefaults()
                    self.data = objects
                    //defaults.setObject(objects, forKey: "data")
                    self.ParkingTable.reloadData()
                }
                let alert = UIAlertController(title: "Alert", message: "Updated Successfully", preferredStyle: UIAlertControllerStyle.Alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(ok);
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            
        }
        self.ParkingTable.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "event") {
            let view = segue.destinationViewController as! EventViewController
            view.data = self.data
            view.eventData = self.eventData
        }else if (segue.identifier == "parkingDetail") {
            let view = segue.destinationViewController as! ParkingDetailsViewController
            view.data = self.data
            view.eventData = self.eventData
            view.array = self.array
        }
    }


}

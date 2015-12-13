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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = NSUserDefaults.standardUserDefaults()
        //eventData = defaults.arrayForKey("eventData") as! [NSMutableArray]
        ParkingTable.reloadData()
        // Do any additional setup after loading the view.
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
        
        
        cell.garageName.text = garageInfo["garageName"] as? String
        
    
        cell.openSpot.text = String(garageInfo["openSpots"])
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
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
        }
    }


}

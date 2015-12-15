/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameInsert: UITextField!
    @IBOutlet weak var passwordInsert: UITextField!
    var loginPass : Bool = false
    
    @IBAction func logIn(sender: AnyObject) {
       
    }
    
    var query = PFQuery(className:"Garage_Info")
    var query2 = PFQuery(className:"specialEvents")
    var data = [PFObject]()
    var eventData = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
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
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            
        }
        
        query2.whereKey("objectId", notEqualTo:"")
        query2.orderByAscending("Date")
        query2.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) events.")
                // Do something with the found objects
                if let objects = objects {
                    self.eventData = objects
                    //let defaults2 = NSUserDefaults.standardUserDefaults()
                    //defaults2.setObject(objects, forKey: "eventData")
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        PFUser.logInWithUsernameInBackground(usernameInsert.text!, password:passwordInsert.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.loginPass = true
                // Do stuff after successful login.
                print("logined in")
            } else {
                self.loginPass = false
                // The login failed. Check error to see w....hy.
            }
        }
        print(loginPass)
        if (segue.identifier == "popover") {
            var ses : signup = segue.destinationViewController as! signup
        } else if (segue.identifier == "confirmedLogin") {
            print(loginPass)
            if (loginPass == false) {
                let alert = UIAlertController(title: "Alert", message: "Login Failed", preferredStyle: UIAlertControllerStyle.Alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(ok);
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                let view : ParkingViewController = segue.destinationViewController as! ParkingViewController
                view.data = self.data
                view.eventData = self.eventData
                view.dateShow = false
            }
        }
    }
}

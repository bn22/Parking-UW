//
//  signup.swift
//  ParkingUW
//
//  Created by Bruce Ng on 12/8/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import Foundation

class signup: UIViewController {
    
    @IBOutlet weak var usernameSign: UITextField!
    @IBOutlet weak var passwordSign: UITextField!
    @IBOutlet weak var emailSign: UITextField!
    var verfied = false
    
    @IBAction func done(sender: AnyObject) {
        var user = PFUser()
        user.username = usernameSign.text!
        user.password = passwordSign.text!
        user.email = emailSign.text!
        let suffix = String(user.email!.characters.suffix(7)) // ground
        if (suffix == "@uw.edu") {
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? NSString
                    let alert = UIAlertController(title: "Alert", message: "Your username or email is taken", preferredStyle: UIAlertControllerStyle.Alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    alert.addAction(ok);
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Alert", message: "You have successfully registered", preferredStyle: UIAlertControllerStyle.Alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    alert.addAction(ok);
                    self.presentViewController(alert, animated: true, completion: nil)                    // Hooray! Let them use the app now.
                }
            }
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please Enter a .uw.edu email", preferredStyle: UIAlertControllerStyle.Alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(ok);
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var ses1 : ViewController = segue.destinationViewController as! ViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
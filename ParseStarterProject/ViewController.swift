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
    
    @IBAction func logIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameInsert.text!, password:passwordInsert.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                print("logined in")
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "popover") {
            var ses : signup = segue.destinationViewController as! signup
        }
    }
}

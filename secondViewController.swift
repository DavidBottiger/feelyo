//
//  secondViewController.swift
//  feelio100001
//
//  Created by David on 2015-12-03.
//  Copyright © 2015 David. All rights reserved.
//

import UIKit
import Parse

class secondViewController: UIViewController {
    
    var gifId = String()
    var gifLikes = Int()
    var gifUsers = [String]()
    var gifObjectId = String()
    var backgroundColor = String()

    override func viewDidLoad() {
        super.viewDidLoad()


    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButton(sender: AnyObject) {
    performSegueWithIdentifier("firstVC", sender: self)
    }
    
    func getGifInfo()
    {
        var user = PFUser.currentUser()
        var query = PFQuery(className:"Gifs")
        query.whereKey("gifId", equalTo:gifId)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                print("Successfully retrieved \(objects!.count) Gifs")
                if let objects = objects {
                    for object in objects {
                        self.gifId = object["gifId"] as! String
                        self.gifObjectId = object["objectId"] as! String
                        self.gifLikes = object["likes"] as! Int
                        self.gifUsers = object["likedByUsers"] as! [String]
                        
                        if (self.gifUsers.contains((user?.username)!))
                        {
                        //Likebutton.hidden = true
                        //Dislikebutton.hidden = false
                        }else{
                        //Likebutton.hidden = false
                        //Dislikebutton.hidden = true
                        }
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    @IBAction func likeButton(sender: UIButton)
    {
        var user = PFUser.currentUser()
        var query = PFQuery(className:"Gifs")
        query.whereKey("gifId", equalTo:gifId)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Gifs")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        self.gifLikes = object["likes"] as! Int
                        self.gifUsers = object["likedByUsers"] as! [String]
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        
        var query2 = PFQuery(className:"Gifs")
        query2.getObjectInBackgroundWithId(self.gifObjectId) {
            (gifInfo: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let gifInfo = gifInfo {

                gifInfo.addObject(user!.username!, forKey: "likedByUsers")
                gifInfo["likes"] = self.gifLikes + 1
                //likebutton.hidden = true
                //dislikebutton.hidden = false
                gifInfo.saveInBackground()
                print("Gif Liked")
                
            }
        }
      }
    }
    
    @IBAction func dislikeButton(sender: UIButton) {
    }
    
}

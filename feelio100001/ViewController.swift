//
//  ViewController.swift
//  feelio100001
//
//  Created by David on 2015-12-03.
//  Copyright © 2015 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var happyImage: UIImageView!

    @IBOutlet weak var pumpedImage: UIImageView!
    @IBOutlet weak var romanticImage: UIImageView!
    @IBOutlet weak var hungryImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

                let imageView = happyImage
                let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
                imageView.userInteractionEnabled = true
                imageView.addGestureRecognizer(tapGestureRecognizer)
        

        }
    
        func imageTapped(img: AnyObject)
        {
            performSegueWithIdentifier("secondVC", sender: self)
            print("ITS WORKING!!!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


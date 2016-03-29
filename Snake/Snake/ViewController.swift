//
//  ViewController.swift
//  Snake
//
//  Created by ze li on 11/23/15.
//  Copyright © 2015 ze li. All rights reserved.
//

import UIKit

class ViewController: UIViewController{


  @IBOutlet weak var sButton: UIButton!
  @IBOutlet weak var StartingPage: UIImageView!
  
  @IBAction func sStart(sender: AnyObject) {
    self.performSegueWithIdentifier("GamePage", sender: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
//    let image = UIImage(named: "sStartingPage.png");
//    let imageview = UIImageView(image: image);
//    self.view.addSubview(imageview);
  
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}


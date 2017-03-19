//
//  PhysicianContainer.swift
//  Sjmo
//
//  Created by Interview on 5/7/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class PhysicianContainer: UIViewController{
    
    var physicianDict:[String:[Physician]]?

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBAction func segmentAction(sender: AnyObject) {
        
        let segment = sender as! UISegmentedControl
        switch segment.selectedSegmentIndex{
        case 0:
           self.performSegueWithIdentifier("Favourites", sender: nil)
        case 1:
            self.performSegueWithIdentifier("All", sender: nil)
        default:
            
             self.performSegueWithIdentifier("All", sender: nil)
        }
        
    }
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backPage(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.physicianDict = CouchBaseHandler.sharedHandler.getSortedPhysicians()
        
        
        // Do any additional setup after loading the view.
        self.performSegueWithIdentifier("All", sender: nil)
        self.segmentControl.selectedSegmentIndex = 1
        
    }

    func downLoadCompleted(image:UIImage){
        
    }
    func downloadError(error:NSError){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "All"{
            let allController = segue.destinationViewController as! PhysicianAllController
            allController.physicanDict = self.physicianDict
        }
    }


}

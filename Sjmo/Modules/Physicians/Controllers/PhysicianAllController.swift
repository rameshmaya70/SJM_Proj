//
//  PhysicianAllController.swift
//  Sjmo
//
//  Created by Interview on 5/7/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class PhysicianAllController: UIViewController,SplListDelegate,SplDoctersDelegate{
    
    var physicanDict : NSDictionary?
    
    var categoryArr:[String]{
        get{
    
            let keysArray = self.physicanDict!.allKeys as! [String]
            
           let sortedArray = keysArray.sorted{ $0 < $1} as Array
           
            return sortedArray
        
        }
    }
    
    var shrinked:Bool = false
    var currentKey:String?
    
    @IBOutlet weak var specialityLabel: UILabel!
    
    @IBOutlet weak var dropDownBn: UIButton!
    
    @IBOutlet weak var slideBn: UIButton!
    
    @IBOutlet weak var slideBnBotConstraint: NSLayoutConstraint!
    
    //Show and hide the list by animation
    
    @IBAction func slideBnAction(sender: AnyObject) {
        
        //Using button tag value to shrink and expand the tableView
        
        let bn = sender as! UIButton
        
        if bn.tag == 0{
            //Expand the table
            expandListController()
            bn.tag = 1
         
        }else{
            shrinkListController()
            bn.tag = 0
         
        }
        
    }
    @IBAction func dropDownBnClicked(sender: AnyObject) {
       
        slideBn.tag = 0
        self.shrinked = true
        self.slideBnBotConstraint.constant = self.view.frame.size.height-107
        self.view.setNeedsLayout()
        self.performSegueWithIdentifier("Speciality", sender: nil)
        self.slideBn.hidden = false
        self.dropDownBn.hidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         specialityLabel.text = "Select Speciality"
        // Do any additional setup after loading the view.
         self.performSegueWithIdentifier("Speciality", sender: nil)
         self.dropDownBn.hidden = true
         self.slideBn.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Speciality"{
            
       let splListController = segue.destinationViewController as! Phy_SplListController
            splListController.delegate = self
            splListController.categoryArray = self.categoryArr
            splListController.physicianDict = self.physicanDict
           
        }
        
        if segue.identifier == "Specialists"{
            
            let splListController = segue.destinationViewController as! Phy_DocterListController
            splListController.delgate = self
            splListController.specialistsArray = self.physicanDict![sender! as! String] as? [Physician]
            
        }
        
        if segue.identifier == "DocterProfile"{
            
            let physicianDetailsController = segue.destinationViewController as! Phy_DetailsViewController
            physicianDetailsController.physicianData = sender as? Physician
           
            
        }

    }
    //MARK: SpecialityDeleagtes
    
    func specialityListSelected(key:String){
        self.dropDownBn.hidden = false
        self.slideBn.hidden = true
        self.shrinked = false
        self.currentKey = key
        self.performSegueWithIdentifier("Specialists", sender: key)
       
      //  specialityLabel.text = tableData?.objectAtIndex(index)
    }
    //MARK: SpecialityDoctersDeleagtes
    
    func specialityDocterListSelected(physician:Physician){
        self.performSegueWithIdentifier("DocterProfile", sender: physician)
    }
    
    func listControllerLoaded(){
        if self.shrinked{
             expandListController()
        }
       
    }
    
    //MARK: helper methods
    
    func shrinkListController(){
        let childController = self.childViewControllers[0] as! UIViewController
        self.slideBn.tag = 0
        UIView.animateWithDuration(0.4, animations: {
            
            //Shrink the table
            
            self.slideBnBotConstraint.constant = self.view.frame.size.height-107
            childController.view.frame = CGRectMake(0, 60, self.view.frame.size.width, 0)
            self.view.layoutIfNeeded()
            
            }, completion: {
                (value: Bool) in
                self.shrinked = false
                self.slideBn.hidden = true
                self.dropDownBn.hidden = false
                self.performSegueWithIdentifier("Specialists", sender: self.currentKey!)
                
        })
        
    }
    
    func expandListController(){
        self.slideBn.tag = 1
        let childController = self.childViewControllers[0] as! UIViewController
        
        UIView.animateWithDuration(0.4, animations: {
            
            self.slideBnBotConstraint.constant = 0
            self.view.layoutIfNeeded()
            childController.view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-107)
            }, completion: {
                (value: Bool) in
                
        })
    }
}

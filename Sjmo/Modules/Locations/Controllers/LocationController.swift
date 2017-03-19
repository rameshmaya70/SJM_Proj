//
//  LocationController.swift
//  Sjmo
//
//  Created by Interview on 5/11/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class LocationController: UIViewController {
    
    var rootLocationsArray : [[String:[LocationData]]]?
    
    var locDict:[String:[LocationData]]?
    var locationsArray:[LocationData]?
    var tableIndex:Int = 0


    @IBAction func backPage(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func rightButton(sender: AnyObject) {
        
        self.performSegueWithIdentifier("LocationCarousel", sender: nil)
        
        
    }
    
    
    
    
    
    func getLocationsArray()-> [LocationData]{
        
        var locArray:[LocationData] = Array<LocationData>()
     
        
        for(var i = 0 ; i < self.rootLocationsArray!.count; i++){
            
            let dict = rootLocationsArray![i] as [String: [LocationData]]
            
            let key:String = dict.keys.array[0]
           
            let sortedArr = dict[key]!.sorted { $0.name < $1.name }
            
            locArray += sortedArr
            
        }
        
        return locArray
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootLocationsArray = CouchBaseHandler.sharedHandler.getLocationsData()

        // Do any additional setup after loading the view.
        self.performSegueWithIdentifier("LocTableCell", sender: nil)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LocTableCell"{
            let tableController = segue.destinationViewController as! Loc_TableController
            tableController.rootLocationsArray = self.rootLocationsArray!
            tableController.locationsArray = getLocationsArray()
            
        }
        if segue.identifier == "LocationCarousel"{
            let carouselController = segue.destinationViewController as! Loc_CarouselController
            carouselController.locationsArray = getLocationsArray()
            carouselController.currentIndex = self.tableIndex
        }
    }
    
    

}

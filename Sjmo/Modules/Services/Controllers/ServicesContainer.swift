//
//  ServicesContainer.swift
//  Sjmo
//
//  Created by Interview on 5/12/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit
class ServicesContainer: UIViewController {
    
    var servicesArray:[ServiceModel]?

    @IBAction func backPage(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   

        servicesArray = CouchBaseHandler.sharedHandler.getServicesData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return servicesArray!.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let service = self.servicesArray![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("services", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.backgroundView?.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        cell.textLabel?.text = service.name
        
        
        return cell
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let service = self.servicesArray![indexPath.row]
        self.performSegueWithIdentifier("seviceDetails", sender: service)
    }

    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "seviceDetails" {
            
            let detailController = segue.destinationViewController as! SrevicesDetail
            detailController.serviceModel = sender as? ServiceModel
            
        }
        
    }
    

}

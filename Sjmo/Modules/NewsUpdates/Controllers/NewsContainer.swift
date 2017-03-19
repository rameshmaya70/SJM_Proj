//
//  NewsContainer.swift
//  Sjmo
//
//  Created by Interview on 5/14/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit
import EventKit

class NewsContainer: UIViewController {
    
    var tableData:[String]?
    
    @IBAction func backPage(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
   
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData = ["Allergy & Immunology", "Ambulatory Care", "Anesthesiology", "Behavioral Medicine", "Cardiology","Dentistry"]

        // Do any additional setup after loading the view.
    }
    func getCurrentData()->(String,String){
        let date = NSDate()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MMMM"
        let dateStr = formatter.stringFromDate(date) as String
//        let calendar = NSCalendar.currentCalendar()
//        
//        let components = calendar.components(.CalendarUnitDay | .z, fromDate: date)
//        let day = components.day
//        let month = components.month
//        return ("\(day)", "\(month)")
//
        let arr = dateStr.componentsSeparatedByString("-") as NSArray
        
        return (arr[0] as! String,arr[1] as! String)
        
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
        return tableData!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsIdentifier", forIndexPath: indexPath) as! NewsCell
        
        // Configure the cell...
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.backgroundView?.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        
        let currentDate:(String,String) = getCurrentData()
        
        cell.dateLabel.text = currentDate.0 as String
        
        cell.monthLabel.text = currentDate.1 as String
        
       // cell.textLabel?.textColor = UIColor.whiteColor()
       // cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 17)
       // cell.textLabel?.text = (tableData!.objectAtIndex(indexPath.row) as! String)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("NewsDetails", sender: nil)
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}

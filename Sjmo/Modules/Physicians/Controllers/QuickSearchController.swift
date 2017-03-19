//
//  QuickSearchController.swift
//  Sjmo
//
//  Created by Ramesh Khanna on 5/26/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

protocol QuickSearchControllerDelegate: class{
    func dismissQuickSearchController()
    func selectedSpeciality(speciality:String)
    func selectedLocation(location:String)
    
}

class QuickSearchController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    weak var delegate:QuickSearchControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    var currentTableArray:[String]?
    var category:String?
    

    @IBAction func dismissBnTapped(sender: AnyObject) {
        
        self.delegate!.dismissQuickSearchController()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layer.borderColor = UIColor.whiteColor().CGColor
        tableView.layer.borderWidth = 1.0
        // Do any additional setup after loading the view.
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
    
    //MARK: Tableview delegate and DataDources
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.currentTableArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("QuickSearchCell", forIndexPath: indexPath) as! UITableViewCell
        
        let bgView = UIView(frame: cell.frame)
        bgView.backgroundColor = UIColor.sjmoRedColor()
        cell.selectedBackgroundView = bgView
        cell.textLabel!.text = self.currentTableArray![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.category! == "Speciality"{
            self.delegate!.selectedSpeciality(self.currentTableArray![indexPath.row])
            
        }else if self.category! == "Location"{
            self.delegate!.selectedLocation(self.currentTableArray![indexPath.row])
        }
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(30.0)
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel(frame: CGRectMake(0, 0, tableView.frame.size.width, 30))
        headerView.backgroundColor = UIColor.sjmoRedColor()
        headerView.text = "  Please select a \(self.category!)"
        headerView.textColor = UIColor.whiteColor()
        
        return headerView
    }

}

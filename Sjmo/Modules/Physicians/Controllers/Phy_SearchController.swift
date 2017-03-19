//
//  Phy_SearchController.swift
//  Sjmo
//
//  Created by Interview on 5/15/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class Phy_SearchController: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,QuickSearchControllerDelegate {
    
    @IBOutlet weak var resultsLbl: UILabel!
    
    var allPhysicciansArray:[Physician]?
    var filteredArray:[Physician]?
    var physicianSplDict:[String:[Physician]]? = nil
    var physicianLocDict:[String:[Physician]]? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var aniViewHeightCons: NSLayoutConstraint!
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var textFiledBaseView: UIView!
    
    @IBOutlet weak var specialityBn: UIButton!
    
    @IBOutlet weak var locationBn: UIButton!
    
    @IBOutlet weak var moreBnTopCons: NSLayoutConstraint!
    @IBOutlet weak var moreBn: UIImageView!
 
    @IBAction func backPage(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
   
    
    @IBAction func locationBnTapped(sender: AnyObject) {
        
        if physicianLocDict == nil{
            physicianLocDict = sortPhysicianAsPerLocation(self.allPhysicciansArray!)
        }
        let keysArray = physicianLocDict!.keys.array as [String]
        let sortedArray = keysArray.sorted{ $0 < $1} as Array
        let dict : [String:[String]] = ["Location" : sortedArray]
        self.performSegueWithIdentifier("QuickSearchController", sender: dict)
    }
    @IBAction func apecialityBnTapped(sender: AnyObject) {
        
        if physicianSplDict == nil{
        physicianSplDict = CouchBaseHandler.sharedHandler.getSortedPhysicians()
        }
        let keysArray = physicianSplDict!.keys.array as [String]
        let sortedArray = keysArray.sorted{ $0 < $1} as Array
        let dict : [String:[String]] = ["Speciality" : sortedArray]
        self.performSegueWithIdentifier("QuickSearchController", sender: dict)
    }

    @IBAction func swipeDown(sender: UITapGestureRecognizer) {
        
        self.searchBar.resignFirstResponder()
        
        var bnFrame:CGRect = self.moreBn.frame
        if self.moreBn.tag == 0 {
            self.moreBn.tag = 1
             self.moreBn.image = UIImage(named:"Less_Icon")
            UIView.animateWithDuration(0.5, animations: {
             
                self.moreBnTopCons.constant = 71
                self.aniViewHeightCons.constant = 75
             
                self.specialityBn.hidden = false
                self.locationBn.hidden = false
               
                self.view.layoutIfNeeded()
                }, completion: {
                    (voidd:Bool) in
                    

            })
        }else
        {
            self.moreBn.tag = 0
             self.moreBn.image = UIImage(named:"More_Icon")
           
            UIView.animateWithDuration(0.5, animations: {
             
               
                self.moreBnTopCons.constant = -4
                self.aniViewHeightCons.constant = 0
             
                self.view.layoutIfNeeded()
               
                }, completion: {
                    (voidd:Bool) in
                    self.specialityBn.hidden = true
                    self.locationBn.hidden = true
                    
                  
            })
        }
        
        
        
    }
    @IBAction func clearSearchBar(sender: AnyObject) {
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.filteredArray!.removeAll(keepCapacity: true)
        self.tableView.hidden = true
        self.resultsLbl.hidden = true
        self.tableView.reloadData()
    }
    
    @IBAction func moreAction(sender: AnyObject) {
    
        //moreButton.setImage(UIImage(named: "Less_Icon"), forState: UIControlState.Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allPhysicciansArray = CouchBaseHandler.sharedHandler.getallPhysicians()
        
        self.filteredArray = [Physician]()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "QuickSearchController"{
            let quickSearchController = segue.destinationViewController as! QuickSearchController
            quickSearchController.delegate = self
            let dict = sender as? [String:[String]]
            let key = dict!.keys.array[0]
            quickSearchController.category = key
            quickSearchController.currentTableArray = dict![key]
            
        }
        
    }
  

    
    //MARK SearchBar delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredArray!.removeAll(keepCapacity: true)
        
        if count(searchText) == 0{
            self.tableView.hidden = true
            resultsLbl.hidden = true
            self.tableView.reloadData()
            return
        }

        
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0), { () -> Void in
            
            for physician in self.allPhysicciansArray! {
                var wordsForLetter = searchText
                
                let index: String.Index = advance(searchText.startIndex, count(searchText))
                
                if(count(physician.lname) >= count(searchText) && count(physician.fname) >= count(searchText)){
                    let matchingLname:String = physician.lname.substringToIndex(index)
                    let matchingFname:String = physician.fname.substringToIndex(index)
                    
                    if(matchingLname == searchText || matchingFname == searchText){
                        
                        self.filteredArray!.append(physician)
                    }
                }
                
            }
            
            dispatch_sync(dispatch_get_main_queue(), {
                () -> Void in
                
                self.resultsLbl.hidden = false
                self.tableView.hidden = false
                self.tableView.reloadData()
            })
        })

    }
    
    //MARK: TableviewDelegate,DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var count = 0
        if (self.filteredArray != nil && self.filteredArray!.count > 0) {
            
            count = self.filteredArray!.count
        }
        
        return count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableCell", forIndexPath: indexPath) as! UITableViewCell
        let bgColor = (indexPath.row % 2 == 0) ? UIColor.sjmoRedColor() : UIColor.clearColor()
        tableView.backgroundView?.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = bgColor
        cell.backgroundView?.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        
        let physician = self.filteredArray![indexPath.row]       
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        downloadImage(imageView, url: physician.photoUrl)
        
        let nameLbl = cell.contentView.viewWithTag(2) as! UILabel
        nameLbl.text = physician.name
        
        let detailLbl = cell.contentView.viewWithTag(3) as! UILabel
        detailLbl.text = "Detail text goes here"
        
        let deptLbl = cell.contentView.viewWithTag(4) as! UILabel
        deptLbl.text = physician.dept
        
        return cell
        
    }
    
    //MARK: ScrollView Delegate
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    //MARK : Helper methods
    
    //Sorting and ordering the physicians as per thier locations
    
    func sortPhysicianAsPerLocation(physicianArray:[Physician])->([String : [Physician]]){
        
        var resDict:([String:[Physician]]) = [String:[Physician]]()
        
        for physician in physicianArray {
            
            let offAddress:String = physician.office1name
                    
            if resDict[offAddress] == nil {
                var phyArray = Array<Physician>()
                phyArray.append(physician)
                resDict.updateValue(phyArray, forKey: offAddress)
                
            }else{
                
                var phyArray:[Physician] = resDict[offAddress]!
                phyArray.append(physician)
                let sortedArray = phyArray.sorted{ $0.office1name < $1.office1name} as Array
                resDict.updateValue(phyArray, forKey: offAddress)
                
            }
            
        }
        
        return resDict
    }
    
    //MARK: QuickSearchController Delegate
   
    func dismissQuickSearchController(){
        
        let childViewController = self.childViewControllers[0] as! UIViewController
        
        UIView.animateWithDuration(0.5, animations: {
            childViewController.view.frame = CGRectMake(0,self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)
            
            }, completion: {
                (value: Bool) in
                childViewController.willMoveToParentViewController(self)
                childViewController.view.removeFromSuperview()
                childViewController.removeFromParentViewController()
        })
    }
    
    func selectedSpeciality(speciality:String){
        
        dismissQuickSearchController()
        let tapGes = UITapGestureRecognizer()
        swipeDown(tapGes)
        
        self.filteredArray = self.physicianSplDict![speciality]
        tableView.scrollRectToVisible(CGRectMake(0, 0, tableView.frame.size.width, 115), animated: false)
        self.tableView.hidden = false
        resultsLbl.hidden = false
        tableView.reloadData()
        
        
    }
    func selectedLocation(location:String){
        
        dismissQuickSearchController()
        let tapGes = UITapGestureRecognizer()
        swipeDown(tapGes)
        
        self.filteredArray = self.physicianLocDict![location]
        tableView.scrollRectToVisible(CGRectMake(0, 0, tableView.frame.size.width, 115), animated: false)
        self.tableView.hidden = false
        resultsLbl.hidden = false
        tableView.reloadData()
    }
    
    //MARK: Image downloading helper method
    
    func downloadImage(imageView:UIImageView!,url:String){
        
        let imagedownloader = ImageDownloader()
        
        if imagedownloader.checkImageExistance(url){
            
            let originalImage = UIImage(data: imagedownloader.getDownloadedImage(url))
            let cropImage = UIImage.cropImage(originalImage!, frame: CGRectMake(0, 0, 96, 96))
            imageView.image = cropImage
            
        }else{
            
            imageView.image = UIImage(named: "Specialist")
            dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
                
                var data:NSData? = nil
                
                data = imagedownloader.downloadImage(url)
                
                dispatch_async(dispatch_get_main_queue()) {
                    if (data != nil) {
                        let img = UIImage(data:data!)
                        if(img != nil && img!.isKindOfClass(UIImage)){
                            
                            let cropImage = UIImage.cropImage(img!, frame: CGRectMake(0, 0, 96, 96))
                            imageView.image = cropImage
                            imagedownloader.saveImageInDocDirectory(url, data: data!)
                        }
                        
                        
                    }
                    
                    
                }
            }
            
        }
        
    }

}

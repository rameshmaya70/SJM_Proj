//
//  Phy_DocterListController.swift
//  Sjmo
//
//  Created by Interview on 5/7/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

protocol SplDoctersDelegate: class{
    func specialityDocterListSelected(physician:Physician)
}

class Phy_DocterListController: UITableViewController,PhyCollectionDelegate {
    
    var indexArray:[String]?
    var specialistsArray : [Physician]?
    var sortedArray : [[String:[Physician]]]?
   weak var delgate:SplDoctersDelegate!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sortedArray = [Dictionary]()
        self.indexArray = [String]()
        let alphabetArr = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        
        for (var i=0 ; i < alphabetArr.count ; i++){
            
            let element = alphabetArr[i] as String
           
            let filteredArray = self.specialistsArray!.filter{ $0.firstLetter  ==  element}
            if filteredArray.count > 0{
                
                let dict:[String:[Physician]] = [element:filteredArray]
                self.indexArray!.append(element)
                self.sortedArray!.append(dict)
            }
            
            
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.sortedArray!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
//        let dict = self.sortedArray![section]
//        let arr = dict.values.first
//        
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DoctersListCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        
        cell.backgroundView?.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        
        tableView.sectionIndexBackgroundColor = UIColor.clearColor()
        tableView.sectionIndexColor = UIColor.whiteColor()

        
        let dict = self.sortedArray![indexPath.section]
        let key = dict.keys.array.first
        let phyArr = dict[key!]
        
        
        let collectionView = cell.contentView.viewWithTag(111) as! PhyCollectionView
        collectionView.delegate = self
        collectionView.reloadCollectionView(phyArr!)
        


        return cell
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        
        
        return self.indexArray!
    }
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return indexArray![section]
//    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame:CGRectMake(0, 0, tableView.frame.size.width, 40))
        headerView.backgroundColor = UIColor.clearColor()
        let squareView = UIView(frame: CGRectMake(0, 0, 40, 40))
        squareView.backgroundColor = UIColor.sjmoRedColor()
        
        let lbl = UILabel(frame: CGRectMake(10, 10, 20, 20))
        lbl.backgroundColor = UIColor.clearColor()
        lbl.textColor = UIColor.whiteColor()
        lbl.text = indexArray![section]
        squareView.addSubview(lbl)
        
        let borderLbl = UILabel(frame: CGRectMake(0, 39, tableView.frame.size.width, 1))
        borderLbl.backgroundColor = UIColor.sjmoRedColor()
        squareView.addSubview(borderLbl)
        
        headerView.addSubview(squareView)
        return headerView
        
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let dict = self.sortedArray![indexPath.section]
        
        let key = dict.keys.array.first
        
        let phyArr = dict[key!]
        
        let flo:Float = Float(phyArr!.count)/Float(3)
        let multiplier:Float = ceil (flo)
        
        return CGFloat(multiplier * 173.0)
    }


    func selectedPhysicianInCollectionView(physician:Physician){
        
         self.delgate.specialityDocterListSelected(physician)
        
    }
   
    
    
}

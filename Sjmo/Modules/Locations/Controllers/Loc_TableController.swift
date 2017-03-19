//
//  Loc_TableController.swift
//  Sjmo
//
//  Created by Interview on 5/11/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit
import MapKit

class Loc_TableController: UIViewController, frontCardDelegate, backCardDelegate, UIScrollViewDelegate {

    var indexArray:[String] = [String]()

    var mapView:MKMapView?
    var rootLocationsArray:[[String:[LocationData]]]?
    var locationsArray:[LocationData]?

    
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var iPhoneTableView: UITableView!
    @IBOutlet weak var iPadTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear(animated: Bool) {
    
        super.viewDidAppear(animated)
        
        populateScrolView()
        
    }
    func populateScrolView(){
        
        self.scrollView.contentSize = CGSizeMake(CGFloat(self.locationsArray!.count)*scrollView.frame.size.width, scrollView.frame.size.height)
        
        var index:Int = 0
        
        for (index = 0; index < self.locationsArray!.count; index++){
            
            
                let card:NSArray = NSBundle.mainBundle().loadNibNamed("Loc_CarouselCard", owner: self, options: nil)
                let view = card[0] as! Loc_CarouselCard
                view.delegate = self
                let panelView = PanelView(frame: scrollView.frame)
                panelView.tag = index + 1
                panelView.frame = CGRectMake(CGFloat(index)*scrollView.frame.size.width, 0,scrollView.frame.size.width, scrollView.frame.size.height)
                panelView.index = index
                view.frame = panelView.bounds
                view.layer.cornerRadius = 10
                panelView.layer.masksToBounds = true
                panelView.layer.cornerRadius = 10
                panelView.addSubview(view)
            
                let locData = self.locationsArray![panelView.index] as LocationData
                populateDataInFront(view, locData: locData)
                self.scrollView.addSubview(panelView)
            
            
        }
        
        let panelView = self.scrollView.viewWithTag(1) as! PanelView
        let locData = self.locationsArray![panelView.index] as LocationData
        loadMapView(panelView)
        mapLoad(locData.address, mapView:mapView!)
        mapLabel.text = locData.name
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return self.rootLocationsArray!.count
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        let dict = self.rootLocationsArray![section]
        let key = dict.keys.array[0]
        let dataArray:[LocationData] = dict[key]!
        return dataArray.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LocTableCell", forIndexPath: indexPath) as! UITableViewCell
        // Configure the cell...
        
        let dict = self.rootLocationsArray![indexPath.section]
        let key = dict.keys.array[0]
        let dataArray:[LocationData] = dict[key]!
        let locationData = dataArray[indexPath.row] as LocationData
        
         let locData:LocationData = self.locationsArray![indexPath.row]
        if tableView == iPadTableView {
            cell.contentView.backgroundColor = UIColor(red: 0.427, green: 0.407, blue: 0.427, alpha: 0.3)
        }
        
        let marqLbl = cell.contentView.viewWithTag(1) as! MarqueeLabel
       
        marqLbl.text = locationData.name as String!
        marqLbl.animationDelay = 0.0
        marqLbl.textColor = UIColor.whiteColor()
        marqLbl.font =  UIFont(name: "HelveticaNeue-Thick", size: 18)
        marqLbl.restartLabel()
        
        if tableView == iPhoneTableView {
            
         marqLbl.font =  UIFont(name: "HelveticaNeue-Bold", size: 14)
         marqLbl.restartLabel()
        let  statusImgView = cell.contentView.viewWithTag(3) as! UIImageView
            
            if !(locData.days == "All Data") {
                if !(Utility.sharedUtility().isClinicOpen(locData)) {
                    
                    statusImgView.image = UIImage(named:"Closed_Icon")
                    
                }
                else {
                    
                    statusImgView.image = UIImage(named:"Open_Icon")
                    
                    
                }
            }
            else {
                
                  statusImgView.image = UIImage(named:"Open_Icon")
            }

            
        let cellLbl = cell.contentView.viewWithTag(2) as! UILabel
        cellLbl.text = locationData.address!
        cellLbl.textColor = UIColor.whiteColor()
        cellLbl.font =  UIFont(name: "HelveticaNeue-Light", size: 12)

        }
        
        cell.backgroundView?.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        
        tableView.sectionIndexBackgroundColor = UIColor.clearColor()
        tableView.sectionIndexColor = UIColor.whiteColor()
        
        return cell
    }
    

     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let dict = self.rootLocationsArray![section]
        let key = dict.keys.array[0] as String
        
        let headerView = UIView(frame:CGRectMake(0, 0, tableView.frame.size.width, 30))
        headerView.backgroundColor = UIColor.clearColor()
        let squareView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 30))
        squareView.backgroundColor = UIColor(red:0.541, green:0.090, blue:0.2, alpha:1.0)
        // squareView.backgroundColor = UIColor.redColor()
        squareView.layer.borderColor = UIColor.whiteColor().CGColor
        squareView.layer.borderWidth = 1.0
        
        let lbl = MarqueeLabel(frame: CGRectMake(10, 5, 320, 20))
        lbl.backgroundColor = UIColor.clearColor()
        lbl.textColor = UIColor.whiteColor()
        lbl.font =  UIFont(name: "HelveticaNeue-Bold", size: 18)
        //lbl.style = Marquee
        lbl.text = key
        squareView.addSubview(lbl)
        
        headerView.addSubview(squareView)
        return headerView
        
    }
   
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Calculating the index to select the appropriate carousel/scroll card

        var section = (indexPath.section)
        var row     = indexPath.row
        var offsetRows = 0
        while (section > 0) {
            offsetRows += tableView.numberOfRowsInSection(section-1)
            section--
        }
        if offsetRows>0{
            row = row + offsetRows
        }
        
      // iPad tableview logics
        
        if tableView == iPadTableView {
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell!.contentView.backgroundColor = UIColor(red: 155/255.0, green: 30/255.0, blue: 67/255.0, alpha: 1.0)
            
            let locData = self.locationsArray![row]
            mapLabel.text = locData.name
            
            var offset = 0


            
            let offsetPoint = CGPointMake(CGFloat(row) * self.scrollView.frame.size.width, 0)
            
            self.scrollView.setContentOffset(offsetPoint, animated: true)
            
            

        }else{
            
            //iPhone logics
            
            let parentController = self.parentViewController as? LocationController
            parentController?.tableIndex = row
            parentController?.rightButton(0)
            
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func frontFlipkBnTapped(view:UIView){
        
        let panelView = view.superview as! PanelView
        let locData = self.locationsArray![panelView.index] as LocationData
        let indexStr = "\(panelView.index)"
        indexArray.append(indexStr)

        
        let xibArrr:NSArray = NSBundle.mainBundle().loadNibNamed("Loc_FlipCard", owner: self, options: nil)
        let backView = xibArrr[0] as! Loc_FlipCard
        backView.delegate = self
        backView.frame = panelView.bounds
        
        let holidayTime = locData.getCombinedString()
        
        if !(locData.days == "All Data") {
            if !(Utility.sharedUtility().isClinicOpen(locData)) {
                
                backView.statusLbl.backgroundColor = UIColor(red: 184/255.0, green: 0/255.0, blue: 5/255.0, alpha: 1)
                backView.statusLbl.text = "Closed"
                backView.statusLbl.textColor = UIColor.blackColor()
                
            }
            else {
                
                backView.statusLbl.backgroundColor = UIColor(red: 25/255.0, green: 222/255.0, blue: 59/255.0, alpha: 1)
                backView.statusLbl.text = "Open"
                backView.statusLbl.textColor = UIColor.blackColor()
                
                
            }
        }
        else {
            
            backView.statusLbl.backgroundColor = UIColor(red: 25/255.0, green: 222/255.0, blue: 59/255.0, alpha: 1)
            backView.statusLbl.text = "Open"
            backView.statusLbl.textColor = UIColor.blackColor()
            
        }

            backView.sectionLbl.text = locData.category
            
            backView.holidayLbl.text = holidayTime 
            panelView.addSubview(backView)
        
        panelView.addSubview(backView)
        
        UIView.transitionWithView(panelView, duration: 1.0, options:.TransitionFlipFromLeft, animations: {
            
            view.hidden = true
            backView.hidden = false
            
            }, completion: {
                (value: Bool) in
                view.removeFromSuperview()
        })

        
    }
    func backFlipkBnTapped(view:UIView){
        
        
        let panelView = view.superview as! PanelView
        let locData = self.locationsArray![panelView.index] as LocationData
        let xibArrr:NSArray = NSBundle.mainBundle().loadNibNamed("Loc_CarouselCard", owner: self, options: nil)
        let frontView = xibArrr[0] as! Loc_CarouselCard
        frontView.delegate = self
        frontView.frame = panelView.bounds
        panelView.addSubview(frontView)
        
        //adding MapView
        mapView!.frame =  CGRectMake(0, 0,panelView.frame.size.width, panelView.frame.size.height/2)
        frontView.addSubview(mapView!)
        
         populateDataInFront(frontView, locData: locData)
        
        
        UIView.transitionWithView(panelView, duration: 1.0, options:.TransitionFlipFromRight, animations: {
            
            view.hidden = true
            frontView.hidden = false
            
            }, completion: {
                (value: Bool) in
                view.removeFromSuperview()
        })
    }
    
    
    
    func populateDataInFront(view:Loc_CarouselCard,locData:LocationData){
        
        view.delegate = self
        //backView.delegate = self
        
        view.addressLabel.text = locData.address
        view.addressLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        
        if !(locData.days == "All Days") {
            
            view.timeLeft.text = Utility.sharedUtility().hoursAboutToOpenTest(locData)
            view.workingHrsLbl.text = Utility.sharedUtility().openingTime(locData)
            view.workingHrsLbl.text = view.workingHrsLbl.text?.stringByReplacingOccurrencesOfString("Closed", withString: " ")
            
            if !(Utility.sharedUtility().isClinicOpen(locData)) {
                
                view.statusLbl.backgroundColor = UIColor(red: 184/255.0, green: 0/255.0, blue: 5/255.0, alpha: 1)
                view.opensInLabel.text = "Opens In"
                view.statusLbl.text = "Closed"
                view.statusLbl.textColor = UIColor.blackColor()
                
            }
                
            else {
                view.statusLbl.backgroundColor = UIColor(red: 25/255.0, green: 222/255.0, blue: 59/255.0, alpha: 1)
                view.opensInLabel.text = "Closes In"
                view.statusLbl.text = "Open"
                view.statusLbl.textColor = UIColor.blackColor()
                
            }
            
        }
            
        else {
            
            view.statusLbl.backgroundColor = UIColor(red: 25/255.0, green: 222/255.0, blue: 59/255.0, alpha: 1)
            view.workingHrsLbl.text = "24 hrs"
            view.opensInLabel.text = "Closes In"
            view.timeLeft.text = "--"
            view.statusLbl.text = "Open"
            view.statusLbl.textColor = UIColor.blackColor()
            
        }
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if(scrollView == self.scrollView){
            var index = 0
            
            index = Int(scrollView.contentOffset.x / scrollView.frame.width)
            
            let panelView = scrollView.viewWithTag(index+1) as! PanelView
            
//            let locData = self.locationsArray![panelView.index] as LocationData
//            mapLabel.text = locData.category
            
            loadMapView(panelView)
            
            mapView?.layer.masksToBounds = true
            mapView?.layer.cornerRadius = 10
            let locData:LocationData = self.locationsArray![panelView.index]
            
            mapLabel.text = locData.name
            
            mapLoad(locData.address!, mapView:mapView!)
            
        }

    }
    
    func mapLoad(address: String, mapView:MKMapView) {
        
        
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark {
                
                mapView.removeAnnotations(mapView.annotations)
                mapView.addAnnotation(MKPlacemark(placemark: placemark))
                
                mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake (placemark.location.coordinate.latitude, placemark.location.coordinate.longitude), MKCoordinateSpanMake(0.05, 0.05)), animated: true)
            }
        })
        
        
    }
    
    func loadMapView(panelView:PanelView){
        let frontView = panelView.viewWithTag(111) as? Loc_CarouselCard
        if frontView != nil {
            let fakeMapView = frontView?.mapImage
            if mapView == nil {
                mapView = MKMapView(frame:CGRectMake(0, 0, panelView.frame.size.width, panelView.frame.size.height/2))
                mapView!.tag = 333
            }
            panelView.addSubview(mapView!)
        }
    }
}

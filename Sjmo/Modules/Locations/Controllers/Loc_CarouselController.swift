//
//  Loc_CarouselController.swift
//  Sjmo
//
//  Created by Interview on 5/11/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit
import MapKit
class Loc_CarouselController: UIViewController,iCarouselDataSource,iCarouselDelegate,frontCardDelegate,backCardDelegate
{

    
    var locationsDict:[String:[LocationData]]?
    
    var locationsArray:[LocationData]?
    
    var indexArray:[String] = [String]()
    
    var currentIndex:Int?
    
    @IBOutlet weak var carousel: iCarousel!
    var mapView:MKMapView?
    
        
    let carouselFrame = CGRectMake(0, 0, 250, 410) as CGRect
   
    @IBOutlet weak var mapLabel: UILabel!
    
    @IBAction func rightBnTapped(sender: AnyObject) {
        self.carousel.hidden = true
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func backPage(sender: AnyObject) {
        self.carousel.hidden = true
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.type = iCarouselType.CoverFlow2
        carousel.decelerationRate = 0.5
        
        carousel.currentItemIndex = self.currentIndex!

        //self.locationsArray = getLocationsArray()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfItemsInCarousel(carousel: iCarousel!) -> Int {
        
        return self.locationsArray!.count
    }
    
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        
        let indexStr = "\(index)"
            
        var panelView:PanelView? = nil
        let locData = self.locationsArray![index] as LocationData
        
        if view == nil{
            
            
                panelView = PanelView(frame: carouselFrame)
                panelView!.index = index
                panelView!.currentView = "FRONT"
                
                let card:NSArray = NSBundle.mainBundle().loadNibNamed("Loc_CarouselCard", owner: self, options: nil)
                let view = card[0] as! Loc_CarouselCard
                populateDataInFront(view, locData: locData)
                
                view.frame = panelView!.bounds
                view.layer.cornerRadius = 10
                panelView!.layer.masksToBounds = true
                panelView!.layer.cornerRadius = 10
                panelView!.addSubview(view)
            
        }
        else {
            
            panelView = view as? PanelView
            
           
            if contains(self.indexArray, indexStr)
            {
                //create backCard
                
                panelView!.currentView = "BACK"
                mapView?.removeFromSuperview()
                let frontCard = view.viewWithTag(111)
                frontCard?.removeFromSuperview()

                let xibArrr:NSArray = NSBundle.mainBundle().loadNibNamed("Loc_FlipCard", owner: self, options: nil)
                let backView = xibArrr[0] as! Loc_FlipCard
                backView.delegate = self
                backView.frame = panelView!.bounds
                let holidayTime = locData.getCombinedString()
                backView.holidayLbl.text = holidayTime
                backView.sectionLbl.text = locData.category
                panelView!.addSubview(backView)
                
                
            }else{
                
                //create frontCard
                
                panelView!.currentView = "FRONT"
                
                let xibArrr:NSArray = NSBundle.mainBundle().loadNibNamed("Loc_CarouselCard", owner: self, options: nil)
                let frontView = xibArrr[0] as! Loc_CarouselCard
                frontView.delegate = self
                frontView.frame = panelView!.bounds
                panelView!.addSubview(frontView)
                populateDataInFront(frontView, locData: locData)
                let backCard = view.viewWithTag(222)
                backCard?.removeFromSuperview()
                
            }
            
            
            
        }
        
        
        //  let view = UIView(frame:CGRectMake(0, 0, 240, 300))
        // view.backgroundColor = UIColor.redColor()
        return  panelView
        
    }

    func carouselDidEndScrollingAnimation(carousel: iCarousel!) {
        
        let panelView = carousel.currentItemView as! PanelView
        
        let frontView = panelView.viewWithTag(111) as? Loc_CarouselCard
        if (frontView != nil && panelView.currentView == "FRONT"){
            let fakeMapView = frontView?.mapImage
            if mapView == nil {
                mapView = MKMapView(frame: fakeMapView!.bounds)
                mapView!.tag = 333
                //Loading the necessary address
                
            }
            panelView.addSubview(mapView!)
            mapView?.layer.masksToBounds = true
            mapView?.layer.cornerRadius = 10
            let locationData:LocationData = self.locationsArray![carousel.currentItemIndex]
            mapLabel.text = locationData.name
            
            mapLoad(locationData.address!, mapView:mapView!)
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

    //MARK: FrontCard Delegate
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
        
        //let key = self.locationsDict!.keys
        // let key1 = keysArray[panelView.index] as String
        
       // backView.sectionLbl.text = key
        backView.sectionLbl.text = locData.category

        backView.holidayLbl.text = holidayTime //stringByReplacingOccurrencesOfString("Optional" , withString: " ")
        panelView.addSubview(backView)
        UIView.transitionWithView(panelView, duration: 1.0, options:.TransitionFlipFromLeft, animations: {
            
            view.hidden = true
            backView.hidden = false
            
            }, completion: {
                (value: Bool) in
                view.removeFromSuperview()
        })
        
    }
   //MARK: backCard Delegate
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
    func carouselWillBeginDragging(carousel: iCarousel!) {
        
    }
    func carouselWillBeginScrollingAnimation(carousel: iCarousel!) {
        
    }
}

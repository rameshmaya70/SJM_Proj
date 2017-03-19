//
//  Phy_DetailsViewController.swift
//  Sjmo
//
//  Created by Interview on 5/8/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class Phy_DetailsViewController: UIViewController {
    
    var physicianData:Physician?

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var locationView: UITextView!
    @IBOutlet weak var phoneView: UITextView!
    @IBOutlet weak var phyName: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func backPage(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
       // self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBAction func displayHome(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func addRemovephysician(sender: AnyObject) {
        let button = sender as! UIButton
        let tag = button.tag
        
        if tag == 0{
            button.setBackgroundImage((UIImage(named:"Favourite_Selected")), forState: UIControlState.Normal)
            DatabaseHandler.sharedHandler.saveFavourite(self.physicianData!)
            button.tag = 1
        }else{
            button.setBackgroundImage((UIImage(named:"Favourite_Normal")), forState: UIControlState.Normal)
            DatabaseHandler.sharedHandler.removeFavourite(self.physicianData!)
            button.tag = 0
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateData()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if DatabaseHandler.sharedHandler.isFavouritePhysicianAlready(self.physicianData!){
            self.favButton.setBackgroundImage((UIImage(named:"Favourite_Selected")), forState: UIControlState.Normal)
        }
        
    }
    
    
    func  populateData(){
        downloadImage(self.imageView,url: self.physicianData!.photoUrl)
        
        self.nameLbl.text = self.physicianData!.dept
        self.phyName.text = self.physicianData!.name
        self.locationView.text = self.physicianData!.address
        self.locationView.scrollRangeToVisible(NSMakeRange(0, 0))
        self.phoneView.text = self.physicianData!.telephone
        
        populateDataOnScrollView()
        
    }
    
    func populateDataOnScrollView(){
        
        let frame = self.scrollView.frame
        
        var view:UIView = UIView()
        var height:CGFloat = 8.0
        
        
        
        if (self.physicianData!.fax != "NA" && count(self.physicianData!.fax.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())) > 0){
            
            let coun = count(self.physicianData!.fax.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
            
            println("Final:\(coun) -- \(self.physicianData!.fax)")
            
             let captionLbl = UILabel(frame: CGRectMake(8, 8, 25, 14))
            captionLbl.text = "Fax:"
            captionLbl.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
            captionLbl.textColor = UIColor.whiteColor()
            
            let offsetX = 8.0 + captionLbl.frame.origin.x +  captionLbl.frame.size.width
            
            let detailLbl = MarqueeLabel()
            detailLbl.numberOfLines = 0
            detailLbl.animationDelay = 0.0
            detailLbl.text = self.physicianData!.fax
            let heightOfLbl = heightForView(self.physicianData!.fax, font:UIFont(name: "HelveticaNeue-Light", size: 12.0)!, width:frame.size.width - offsetX-15)
            detailLbl.textColor = UIColor.whiteColor()
            detailLbl.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
            detailLbl.frame = CGRectMake(offsetX, captionLbl.frame.origin.y,self.view.frame.size.width - offsetX-50, heightOfLbl)
            detailLbl.lineBreakMode = NSLineBreakMode.ByClipping
             detailLbl.restartLabel()
            
            height += heightOfLbl
            
            view.addSubview(captionLbl)
            view.addSubview(detailLbl)
            
        }
        
        if(self.physicianData!.university1 != "NA" && count(self.physicianData!.university1) > 0){
            
            
            
             let captionLbl = UILabel(frame: CGRectMake(8, height+8, 60, 14))
            captionLbl.text = "University:"
            captionLbl.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
            captionLbl.textColor = UIColor.whiteColor()
            
            let offsetX = 8.0 + captionLbl.frame.origin.x +  captionLbl.frame.size.width
            
            let detailLbl = MarqueeLabel()
            detailLbl.numberOfLines = 0
            detailLbl.animationDelay = 0.0
            detailLbl.text = self.physicianData!.university1
            let heightOfLbl = heightForView(self.physicianData!.university1, font:UIFont(name: "HelveticaNeue-Light", size: 12.0)!, width:250.0)
            detailLbl.textColor = UIColor.whiteColor()
            detailLbl.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
            detailLbl.frame = CGRectMake(offsetX, captionLbl.frame.origin.y,self.view.frame.size.width - offsetX-50, heightOfLbl)
            detailLbl.lineBreakMode = NSLineBreakMode.ByClipping
             detailLbl.restartLabel()
            
            height += heightOfLbl
            
            view.addSubview(captionLbl)
            view.addSubview(detailLbl)
        }
        
        if(self.physicianData!.internship1 != "NA" && count(self.physicianData!.internship1) > 0){
            
             let captionLbl = UILabel(frame: CGRectMake(8, height+8, 60, 14))
            captionLbl.text = "Internship:"
            captionLbl.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
            captionLbl.textColor = UIColor.whiteColor()
            
            let offsetX = 8.0 + captionLbl.frame.origin.x +  captionLbl.frame.size.width
            
            let detailLbl = MarqueeLabel()
            detailLbl.numberOfLines = 0
            detailLbl.animationDelay = 0.0
            detailLbl.text = self.physicianData!.internship1
            let heightOfLbl = heightForView(self.physicianData!.internship1, font:UIFont(name: "HelveticaNeue-Light", size: 12.0)!, width:250.0)
            detailLbl.textColor = UIColor.whiteColor()
            detailLbl.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
            detailLbl.frame = CGRectMake(offsetX, captionLbl.frame.origin.y,self.view.frame.size.width - offsetX-50, heightOfLbl)
            detailLbl.lineBreakMode = NSLineBreakMode.ByClipping
             detailLbl.restartLabel()
            
            height += heightOfLbl
            
            view.addSubview(captionLbl)
            view.addSubview(detailLbl)
        }

        if(self.physicianData!.board1 != "NA" && count(self.physicianData!.board1) > 0){
            
             let captionLbl = UILabel(frame: CGRectMake(8, height+8, 100, 14))
            captionLbl.text = "Board Certification:"
            captionLbl.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
            captionLbl.textColor = UIColor.whiteColor()
            
            let offsetX = 8.0 + captionLbl.frame.origin.x +  captionLbl.frame.size.width
            
            let detailLbl = MarqueeLabel()
            detailLbl.numberOfLines = 0
            detailLbl.animationDelay = 0.0
            detailLbl.text = self.physicianData!.board1
            let heightOfLbl = heightForView(self.physicianData!.board1, font:UIFont(name: "HelveticaNeue-Light", size: 12.0)!, width:250.0)
            detailLbl.textColor = UIColor.whiteColor()
            detailLbl.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
            detailLbl.frame = CGRectMake(offsetX, captionLbl.frame.origin.y,self.view.frame.size.width - offsetX-100, heightOfLbl)
            detailLbl.lineBreakMode = NSLineBreakMode.ByClipping
             detailLbl.restartLabel()
            
            height += heightOfLbl
            
            view.addSubview(captionLbl)
            view.addSubview(detailLbl)
        }

        if(self.physicianData!.fellowship1 != "NA" && count(self.physicianData!.fellowship1) > 0){
            
             let captionLbl = UILabel(frame: CGRectMake(8, height+8, 120, 14))
            captionLbl.text = "Fellowship Information:"
            captionLbl.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
            captionLbl.textColor = UIColor.whiteColor()
            
            let offsetX = 8.0 + captionLbl.frame.origin.x +  captionLbl.frame.size.width
            
            let detailLbl = MarqueeLabel()
            detailLbl.numberOfLines = 0
            detailLbl.text = self.physicianData!.fellowship1
            detailLbl.animationDelay = 0.0
            let heightOfLbl = heightForView(self.physicianData!.fellowship1, font:UIFont(name: "HelveticaNeue-Light", size: 12.0)!, width:250.0)
            detailLbl.textColor = UIColor.whiteColor()
            detailLbl.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
            detailLbl.frame = CGRectMake(offsetX, captionLbl.frame.origin.y,self.view.frame.size.width - offsetX-50, heightOfLbl)
           // detailLbl.backgroundColor = UIColor.blueColor()
            detailLbl.lineBreakMode = NSLineBreakMode.ByClipping
            detailLbl.restartLabel()

            height += heightOfLbl
            
            view.addSubview(captionLbl)
            view.addSubview(detailLbl)
        }

        
        self.scrollView.addSubview(view)
        
        
        
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:MarqueeLabel = MarqueeLabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
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
    
    func downloadImage(imageView:UIImageView!,url:String){
        
        let imageDownloader = ImageDownloader()
        
        if imageDownloader.checkImageExistance(url){
            
            imageView.image = UIImage(data: imageDownloader.getDownloadedImage(url))
            
        }else{
            
            imageView.image = UIImage(named: "Specialist")
            dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
                
                var data:NSData? = nil
                
                data = imageDownloader.downloadImage(url)
                if(data != nil){
                    dispatch_async(dispatch_get_main_queue()) {
                        if let img = UIImage(data:data!){
                            imageView.image = img
                            imageDownloader.saveImageInDocDirectory(url, data: data!)
                        }
                        
                    }
 
                }
            }
            
        }
        
    }

}

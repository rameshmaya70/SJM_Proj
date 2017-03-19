//
//  PhysicianFavController.swift
//  Sjmo
//
//  Created by Interview on 5/7/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class PhysicianFavController: UIViewController,iCarouselDataSource,iCarouselDelegate{

    var physiciansArray:[Physician]?
    
    @IBOutlet weak var carousel: iCarousel!
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.type = iCarouselType.CoverFlow2
        carousel.decelerationRate = 0.5
        
        self.physiciansArray = DatabaseHandler.sharedHandler.getFavourites()
        carousel.reloadData()
        carousel.scrollToItemAtIndex(0, animated: true)
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        carousel.hidden = true
    }
    func numberOfItemsInCarousel(carousel: iCarousel!) -> Int {
        
        var count:Int = 0
        if(self.physiciansArray != nil && self.physiciansArray!.count > 0){
            count = self.physiciansArray!.count
        }
        
        return count
    }
    
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        
        let physician = self.physiciansArray![index] as Physician
        
        var profileCard:ProfileCard? = nil
        
        if(view == nil){
            let cardArr:NSArray = NSBundle.mainBundle().loadNibNamed("ProfileCard", owner: self, options: nil)
            profileCard = cardArr[0] as? ProfileCard
            profileCard!.tag = 111
            profileCard!.frame = CGRectMake(0, 0, 200, 370)
            downloadImage(profileCard!.profileImageView, url: physician.photoUrl)
            profileCard!.nameLbl.text = physician.name
            profileCard!.deptLbl.text = physician.dept
            profileCard!.addTextView.text = physician.address
            
            return profileCard
            
        }else{
            
            profileCard = view as? ProfileCard
            downloadImage(profileCard!.profileImageView, url: physician.photoUrl)
            profileCard!.nameLbl.text = physician.name
            profileCard!.deptLbl.text = physician.dept
            profileCard!.addTextView.text = physician.address
        }
 
        return  profileCard
         
    }

    
    func downloadImage(imageView:UIImageView!,url:String){
        
        let imagedownloader = ImageDownloader()
        
        if imagedownloader.checkImageExistance(url){
            
            imageView.image = UIImage(data: imagedownloader.getDownloadedImage(url))
            
        }else{
            
            imageView.image = UIImage(named: "Specialist")
            dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
                
                var data:NSData? = nil
                
                data = imagedownloader.downloadImage(url)
                
                dispatch_async(dispatch_get_main_queue()) {
                    if (data != nil) {
                        let img = UIImage(data:data!)
                        if(img != nil && img!.isKindOfClass(UIImage)){
                            
                            imageView.image = img
                            imagedownloader.saveImageInDocDirectory(url, data: data!)
                        }
                        
                        
                    }
                    
                    
                }
            }
            
        }
        
    }
}

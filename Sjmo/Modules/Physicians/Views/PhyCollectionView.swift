//
//  PhyCollectionView.swift
//  Sjmo
//
//  Created by Ramesh Khanna on 5/22/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

protocol PhyCollectionDelegate: class{
    func selectedPhysicianInCollectionView(physician:Physician)
}

class PhyCollectionView: UIView,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var physicainArray:[Physician]?
    @IBOutlet weak var collectionView:UICollectionView!
    
    weak var delegate:PhyCollectionDelegate?
    
    func reloadCollectionView(phyArray:[Physician]){
        self.physicainArray = phyArray
        self.collectionView .reloadData()
    }
    
    
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.physicainArray!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhyCollectionCell", forIndexPath: indexPath) as! PhyCollectionCell
        
        let physician = self.physicainArray![indexPath.row] as Physician
        
        let formattedName = "\(physician.name),\(physician.degree)"
        cell.nameLbl.text = formattedName
        cell.nameLbl.textColor = UIColor.whiteColor()
        cell.nameLbl.font = UIFont(name:"HelveticaNeue-Light", size: 15)
        cell.nameLbl.restartLabel()
        
        let offName = physician.office1name
        if offName != "NA"{
        cell.detailLbl.text = physician.office1name
        }
        cell.detailLbl.textColor = UIColor.whiteColor()
        cell.detailLbl.restartLabel()
        cell.detailLbl.font = UIFont(name:"HelveticaNeue-Light", size: 12)
        downloadImage(cell.profileImageView ,url:physician.photoUrl)
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.delegate!.selectedPhysicianInCollectionView(self.physicainArray![indexPath.row] as Physician)
        
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

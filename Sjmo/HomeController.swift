//
//  HomeController.swift
//  Sjmo
//
//  Created by Interview on 5/6/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class HomeController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,MBProgressHUDDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var iconsArray:NSArray?
    let screenWidth = UIScreen.mainScreen().applicationFrame.width
    let screenHeight = UIScreen.mainScreen().applicationFrame.height
    var progressView:MBProgressHUD?
    var selectedIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        addProgressView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideProgress", name:"ProgressNotif", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAlert", name:"NoInternet", object: nil)
        CouchBaseHandler.sharedHandler.syncRemoteDb()
        let path = NSBundle.mainBundle().pathForResource("ModulesList", ofType: "plist")
        self.iconsArray = NSArray(contentsOfFile: path!)
        
        designCollectionViewLayout()
    
        // Do any additional setup after loading the view.
    }
    
    func addProgressView(){
        
        self.progressView = MBProgressHUD(view: self.navigationController!.view)
        self.navigationController!.view.addSubview(self.progressView!)
        self.progressView!.delegate = self
        self.progressView!.labelText = "Loading"
        self.progressView!.detailsLabelText = "Please Wait"
        self.progressView!.square = true
        self.progressView!.show(true)
    }
    
    func designCollectionViewLayout(){
        
        let cellWidth = (screenWidth-60) / 2
        let cellHeight = ((0.85 * screenHeight) - 90) / 3
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.collectionView.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconsArray!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeIconCell", forIndexPath: indexPath) as! HomeCollectionCell
        let itemDict = iconsArray![indexPath.row] as! NSDictionary
        
        if(self.selectedIndex == nil){
            cell.imageView.image = UIImage(named:itemDict["imageUnsel"] as! NSString as String)
            
        }else{
            cell.imageView.image = UIImage(named:itemDict["imageSel"] as! NSString as String)
            
        }
        
        cell.titleLbl.text = itemDict["name"] as! NSString as String
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let itemDict = iconsArray![indexPath.row] as! NSDictionary
        self.selectedIndex = indexPath.row
        collectionView.reloadItemsAtIndexPaths([indexPath])
        let storyBoardName = itemDict["storyBoard"] as! NSString as String
        let storyBoardString = "\(storyBoardName)"
        let storyBaord:UIStoryboard = UIStoryboard(name: storyBoardString, bundle:NSBundle.mainBundle())
        let viewController: AnyObject = storyBaord.instantiateInitialViewController()
        self.navigationController?.pushViewController(viewController as! UIViewController, animated: true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedIndex = nil
        self.collectionView.reloadData()
       
    }
 
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = NSIndexPath(index: self.selectedIndex!)
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }

    
    func hideProgress(){
        
        self.progressView!.hide(false)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ProgressNotif", object: nil)
        //showFailureAlert()
    }
    
    func showAlert(){
        
        self.progressView!.hide(false)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoInternet", object: nil)
    }
    
    func showFailureAlert(){
        let alertController = UIAlertController(title: "Service Failure", message: "Please try again later", preferredStyle:.Alert)
        let okaction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okaction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }

}

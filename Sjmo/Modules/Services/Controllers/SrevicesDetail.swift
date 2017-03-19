//
//  SrevicesDetail.swift
//  Sjmo
//
//  Created by Interview on 5/12/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class SrevicesDetail: UIViewController,overlayDismiisDelegate {
    
    var serviceModel:ServiceModel?

    @IBOutlet weak var tilteLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBAction func refferalButton(sender: AnyObject) {
    }
    
    @IBAction func homeBnTapped(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func backPage(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.text = self.serviceModel!.desc
        self.tilteLbl.text = self.serviceModel!.name
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.textView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Overlay"{
            let overlayController = segue.destinationViewController as! ServicesOverlayController
            overlayController.delegate = self
        }
    }
 
    
    //MARK:OverLayDelegate
    func dismissOverlay(){
        
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
}

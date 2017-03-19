//
//  CustPresentSegue.swift
//  Sjmo
//
//  Created by Interview on 5/12/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class CustPresentSegue: UIStoryboardSegue {
    
    
    override func perform() {
        
        let parentController: AnyObject = self.sourceViewController;
        let childController:AnyObject = self.destinationViewController
        removeChilds(parentController as! UIViewController)
        addChild(childController as! UIViewController, parentController: parentController as! UIViewController)
        
    }
    
    func removeChilds(parentController:UIViewController){
        
        for (var i=0;i<parentController.childViewControllers.count; i++){
            
            let childViewController = parentController.childViewControllers [i] as! UIViewController
            childViewController.willMoveToParentViewController(parentController)
            childViewController.view.removeFromSuperview()
            childViewController.removeFromParentViewController()
            
        }
        
    }
    
    func addChild(childController:UIViewController, parentController:UIViewController){
        
        
        let frame = parentController.view.frame
        var originY:CGFloat = 0
        var height:CGFloat = frame.size.height
        childController.view.frame = CGRectMake(0,frame.size.height, frame.width,height)
        
       
        UIView.animateWithDuration(0.5, animations: {
            
            parentController.view.addSubview(childController.view)
            childController.view.frame = CGRectMake(0, originY, frame.width,height)
            parentController.addChildViewController(childController)
            childController.didMoveToParentViewController(parentController)
            
            }, completion: {
                (value: Bool) in
        })
        
        
        
    }

   
}

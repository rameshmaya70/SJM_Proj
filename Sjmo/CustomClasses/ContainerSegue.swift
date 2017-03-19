//
//  EmptySegue.swift
//  BofaNew
//
//  Created by Ramesh Khanna on 2/27/15.
//  Copyright (c) 2015 Ramesh Khanna. All rights reserved.
//

import UIKit

class ContainerSegue: UIStoryboardSegue {
    
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
        var originY:CGFloat = -frame.size.height
        var height:CGFloat = frame.size.height
        if parentController is PhysicianContainer{
            originY = 104
            height = frame.size.height-104
        }
        
        else if parentController is PhysicianAllController {
            let vc = parentController as! PhysicianAllController
            originY = 60
            height = frame.size.height-60
            if vc.shrinked{
               height = 0
            }
        }
        
        else if parentController is LocationController {
           
            originY = 60
            height = frame.size.height-60
            
        }
        
        

        parentController.view.addSubview(childController.view)
        childController.view.frame = CGRectMake(0, originY, frame.width,height)
        parentController.addChildViewController(childController)
        childController.didMoveToParentViewController(parentController)
        
    }
   
}

//
//  ServicesOverlayController.swift
//  Sjmo
//
//  Created by Interview on 5/12/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

protocol overlayDismiisDelegate: class{
    func dismissOverlay()
}

class ServicesOverlayController: UIViewController {
    
    weak var delegate:overlayDismiisDelegate!

    @IBAction func dismissAction(sender: AnyObject) {
        self.delegate.dismissOverlay()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

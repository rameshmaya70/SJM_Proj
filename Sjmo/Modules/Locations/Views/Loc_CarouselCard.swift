//
//  Loc_CarouselCard.swift
//  Sjmo
//
//  Created by Interview on 5/11/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

protocol frontCardDelegate: class
{
    func frontFlipkBnTapped(view:UIView)
    
}

class Loc_CarouselCard: UIView {
    
    @IBOutlet weak var mapImage: UIImageView!
    weak var delegate:frontCardDelegate!

    @IBAction func clockBnTapped(sender: AnyObject) {
        self.delegate.frontFlipkBnTapped(self)
        
    }
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var timeLeft: UILabel!
    
    @IBOutlet weak var opensInLabel: UILabel!
   
    @IBOutlet weak var workingHrsLbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}


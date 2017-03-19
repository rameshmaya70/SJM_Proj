//
//  Loc_FlipCard.swift
//  Sjmo
//
//  Created by Interview on 5/12/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

protocol backCardDelegate: class
{
    func backFlipkBnTapped(view:UIView)
}

class Loc_FlipCard: UIView {
    
    weak var delegate:backCardDelegate!

    @IBOutlet weak var holidayLbl: UILabel!
//    @IBOutlet weak var holidayHrLbl: UIView!
    @IBAction func backFlipBnTapped(sender: AnyObject) {
        self.delegate.backFlipkBnTapped(self)
        
    }
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var sectionLbl: UILabel!
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

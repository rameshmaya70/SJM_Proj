//
//  ServiceModel.swift
//  Sjmo
//
//  Created by Ramesh Khanna on 5/29/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class ServiceModel: NSObject {
    
    var name:String?
    var desc:String?
    var phone:String?
    var idValue:String?
    var mapping:String?
    
    init(dic:NSDictionary){
        
        self.name = dic["Name"]! as? String
        self.desc = dic["Description"]! as? String
        self.phone = dic["Phone"]! as? String
        self.idValue =  dic["ID"]! as? String
        self.mapping = dic["Mapping"]! as? String
        
        
    }
    

}

//
//  PhysicianEntity.swift
//  Sjmo
//
//  Created by Ramesh Khanna on 5/27/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import Foundation
import CoreData

class PhysicianEntity: NSManagedObject {

    @NSManaged var fname: String
    @NSManaged var lname: String
    @NSManaged var middlename: String
    @NSManaged var degree: String
    @NSManaged var sex: String
    @NSManaged var email: String
    @NSManaged var photo: String
    @NSManaged var dept: String
    @NSManaged var officeAdd1a: String
    @NSManaged var officeAdd1b: String
    @NSManaged var office1city: String
    @NSManaged var office1state: String
    @NSManaged var office1zip: String
    @NSManaged var speciality2: String
    @NSManaged var board1: String
    @NSManaged var board2: String
    @NSManaged var board3: String
    @NSManaged var university1: String
    @NSManaged var fellowship1: String
    @NSManaged var fellowship2: String
    @NSManaged var internship1: String
    @NSManaged var office1name: String
    @NSManaged var office1tele1: String
    @NSManaged var office1tele2: String
    @NSManaged var office1fax: String
    @NSManaged var office2name: String
    @NSManaged var offAddr2a: String
    @NSManaged var offAddr2b: String
    @NSManaged var office2city: String
    @NSManaged var office2state: String
    @NSManaged var office2zip: String
    @NSManaged var office2tele1: String
    @NSManaged var office2tele2: String
    @NSManaged var office2fax: String
    @NSManaged var office3name: String
    @NSManaged var offAddr3a: String
    @NSManaged var offAddr3b: String
    @NSManaged var office3city: String
    @NSManaged var office3state: String
    @NSManaged var office3zip: String
    @NSManaged var office3tele1: String
    @NSManaged var office3tele2: String
    @NSManaged var office3fax: String
    @NSManaged var medicareid: String
    @NSManaged var membership: String

}

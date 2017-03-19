//
//  DatabaseHandler.swift
//  Sjmo
//
//  Created by Ramesh Khanna on 5/22/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit
import CoreData
class DatabaseHandler: NSObject {
    
    var managedContext:NSManagedObjectContext?
    
    
    class var sharedHandler: DatabaseHandler {
        struct Static {
            static var instance: DatabaseHandler?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = DatabaseHandler()
        }
        
        return Static.instance!
    }
    
    override init(){
        super.init()
    
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedContext = appDel.managedObjectContext
    }
    
    func saveFavourite(physician:Physician){
        
        if(!isFavouritePhysicianAlready(physician)){
            
            let managedObject = NSEntityDescription.insertNewObjectForEntityForName("PhysicianEntity", inManagedObjectContext: self.managedContext!) as! NSManagedObject
            
            managedObject.setValue(physician.fname, forKey: "fname")
            managedObject.setValue(physician.lname, forKey: "lname")
            managedObject.setValue(physician.middlename, forKey: "middlename")
            managedObject.setValue(physician.degree, forKey: "degree")
            managedObject.setValue(physician.sex, forKey: "sex")
            
            managedObject.setValue(physician.email, forKey: "email")
            managedObject.setValue(physician.lname, forKey: "lname")
            managedObject.setValue(physician.photo, forKey: "photo")
            managedObject.setValue(physician.dept, forKey: "dept")
            managedObject.setValue(physician.officeAdd1a, forKey: "officeAdd1a")
            
            
            managedObject.setValue(physician.officeAdd1b, forKey: "officeAdd1b")
            managedObject.setValue(physician.office1city, forKey: "office1city")
            managedObject.setValue(physician.office1state, forKey: "office1state")
            managedObject.setValue(physician.office1zip, forKey: "office1zip")
            managedObject.setValue(physician.speciality2, forKey: "speciality2")
            
            managedObject.setValue(physician.board1, forKey: "board1")
            managedObject.setValue(physician.board2, forKey: "board2")
            managedObject.setValue(physician.board3, forKey: "board3")
            managedObject.setValue(physician.university1, forKey: "university1")
            managedObject.setValue(physician.fellowship1, forKey: "fellowship1")
            
            managedObject.setValue(physician.fellowship2, forKey: "fellowship2")
            managedObject.setValue(physician.internship1, forKey: "internship1")
            managedObject.setValue(physician.office1name, forKey: "office1name")
            managedObject.setValue(physician.office1tele1, forKey: "office1tele1")
            managedObject.setValue(physician.office1tele2, forKey: "office1tele2")
            
            managedObject.setValue(physician.office1fax, forKey: "office1fax")
            managedObject.setValue(physician.office2name, forKey: "office2name")
            managedObject.setValue(physician.offAddr2a, forKey: "offAddr2a")
            managedObject.setValue(physician.offAddr2b, forKey: "offAddr2b")
            managedObject.setValue(physician.office2city, forKey: "office2city")
            
            managedObject.setValue(physician.office2state, forKey: "office2state")
            managedObject.setValue(physician.office2zip, forKey: "office2zip")
            managedObject.setValue(physician.office2tele1, forKey: "office2tele1")
            managedObject.setValue(physician.office2tele2, forKey: "office2tele2")
            managedObject.setValue(physician.office2fax, forKey: "office2fax")
            
            managedObject.setValue(physician.office3name, forKey: "office3name")
            managedObject.setValue(physician.offAddr3a, forKey: "offAddr3a")
            managedObject.setValue(physician.offAddr3b, forKey: "offAddr3b")
            managedObject.setValue(physician.office3city, forKey: "office3city")
            managedObject.setValue(physician.office3state, forKey: "office3state")
            
            managedObject.setValue(physician.office3zip, forKey: "office3zip")
            managedObject.setValue(physician.office3tele1, forKey: "office3tele1")
            managedObject.setValue(physician.office3tele2, forKey: "office3tele2")
            managedObject.setValue(physician.office3fax, forKey: "office3fax")
            managedObject.setValue(physician.medicareid, forKey: "medicareid")
            managedObject.setValue(physician.membership, forKey: "membership")

            
            var error:NSError? = nil
            self.managedContext!.save(&error)
        }
        
        
        
    }
    
    func isFavouritePhysicianAlready(physician:Physician)->(Bool){
        
        let entityDesc = NSEntityDescription.entityForName("PhysicianEntity", inManagedObjectContext: self.managedContext!)
        
        var fetchReq:NSFetchRequest = NSFetchRequest()
        fetchReq.entity = entityDesc
        let predicate =  NSPredicate(format: "fname = %@ AND lname = %@", physician.fname,physician.lname)
        fetchReq.predicate = predicate
        
        var error:NSError? = nil
        let object:[AnyObject]? = self.managedContext!.executeFetchRequest(fetchReq, error: &error)
        
        return object?.count>0 ? true : false
        
    }
    
    func removeFavourite(physician:Physician){
        
        let entityDesc = NSEntityDescription.entityForName("PhysicianEntity", inManagedObjectContext: self.managedContext!)
        
        var fetchReq:NSFetchRequest = NSFetchRequest()
        fetchReq.entity = entityDesc
        let predicate =  NSPredicate(format: "fname = %@ AND lname = %@", physician.fname,physician.lname)
        fetchReq.predicate = predicate
        
        var error:NSError? = nil
        let object:[AnyObject]? = self.managedContext!.executeFetchRequest(fetchReq, error: &error)
        
        self.managedContext!.deleteObject(object![0] as! NSManagedObject)
        
        self.managedContext!.save(&error)
        
    }
    
    func getFavourites()->([Physician]){
        
        var physicianArray:[Physician] = [Physician] ()
        
        let entityDesc = NSEntityDescription.entityForName("PhysicianEntity", inManagedObjectContext: self.managedContext!)
        
        var fetchReq:NSFetchRequest = NSFetchRequest()
        fetchReq.entity = entityDesc
        
        var error:NSError? = nil
        let object:[AnyObject]? = self.managedContext!.executeFetchRequest(fetchReq, error: &error)
        
        for (var i = 0; i < object!.count ; i++ ){
            
             let phyEntity = object![i] as? NSManagedObject
                
             let physician = Physician(physicianEntity: phyEntity!)
            
             physicianArray.append(physician)
        }
        
        return physicianArray
        
    }
    
    func saveSyncupStatus(flag:Bool){
        
        let managedObject = NSEntityDescription.insertNewObjectForEntityForName("SyncStatus", inManagedObjectContext: self.managedContext!) as! NSManagedObject
        
        managedObject.setValue(flag, forKey: "flag")
        var error:NSError? = nil
        self.managedContext!.save(&error)
        
    }
    func getSyncUpStatus()->(NSNumber){
        
        let entityDesc = NSEntityDescription.entityForName("SyncStatus", inManagedObjectContext: self.managedContext!)
        
        var fetchReq:NSFetchRequest = NSFetchRequest()
        fetchReq.entity = entityDesc
        
        var error:NSError? = nil
        let object:[AnyObject]? = self.managedContext!.executeFetchRequest(fetchReq, error: &error)
        
        var status:NSNumber = 0
        
        if object!.count > 0{
        let phyEntity = object![0] as! NSManagedObject
            status = phyEntity.valueForKey("flag") as! Bool
        }
        
        return status
    }
   
}

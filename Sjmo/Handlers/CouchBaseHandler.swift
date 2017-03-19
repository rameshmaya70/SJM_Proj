//
//  CouchBaseHandler.swift
//  Sjmo
//
//  Created by Ramesh Khanna on 5/18/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit
class CouchBaseHandler: NSObject {
    
    var manager:CBLManager?
    var database:CBLDatabase?
    var pull:CBLReplication?
    var syncCompleted:Bool = false
    
    
    var couchBaseDic:NSDictionary{
    
        get{
            
            let plistPath = NSBundle.mainBundle().pathForResource("ConfigureList", ofType: "plist")
            let configDic:NSDictionary = NSDictionary(contentsOfFile: plistPath!)!
            return configDic["CouchBase"] as! NSDictionary
        }
    
   
    }
    
    class var sharedHandler: CouchBaseHandler {
        struct Static {
            static var instance: CouchBaseHandler?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = CouchBaseHandler()
        }
        
        return Static.instance!
    }
    
    override init(){
        super.init()
        setupDataBase()
    }
    func setupDataBase(){
        
        
        var error:NSError?
        
        self.manager = CBLManager.sharedInstance()
        if self.manager != nil {
            self.database = self.manager!.databaseNamed(self.couchBaseDic["dbName"] as! NSString as String, error: &error)
        }
    }
    
    func syncRemoteDb(){
        
        let networkStatus = hasConnectivity()
        if networkStatus {
            
            makePullReplication()
        
        }else{
             makePullReplication()
        }
    }
    
     func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
    }
    
    func makePullReplication(){
        
        
        let serverDbURL = NSURL(string: self.couchBaseDic["url"] as! NSString as String)
        
        let auth = CBLAuthenticator.basicAuthenticatorWithName(self.couchBaseDic["username"] as! NSString as String, password: self.couchBaseDic["password"] as! NSString as String)
        
        self.pull = self.database!.createPullReplication(serverDbURL!)
        self.pull!.authenticator = auth!
        self.pull!.continuous = true
       
        
        // Observe replication progress changes, in both directions:
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"replicationProgress:", name:kCBLReplicationChangeNotification, object: self.pull!)
    
       self.pull!.start()
    }
    
    //MARK: Replication Delegate Method
    
    func replicationProgress(notif:NSNotificationCenter){
        
        let completed = self.pull!.completedChangesCount
        let total = self.pull!.changesCount
       
        
        let syncValue = DatabaseHandler.sharedHandler.getSyncUpStatus()
        
        println(self.pull!.status.rawValue)
      
      
        if (self.pull!.status == CBLReplicationStatus.Active){
          
            NSNotificationCenter.defaultCenter().postNotificationName("ProgressNotif", object: self.pull!)
        }
        
       
    }
   
    func getLocationsData()->([[String:[LocationData]]]){
        
        var locationsArray:NSMutableArray = NSMutableArray()
        
        var retArray:[[String:[LocationData]]] = [[String:[LocationData]]]()
        
        var error:NSError? = nil
        
        var queryEnumerator = CBLQueryEnumerator()
        var query:CBLQuery = self.database!.createAllDocumentsQuery()
        
        let view:CBLView = self.database!.viewNamed("view_by_ID")
        
        if view.mapBlock == nil {
            var mapBlock: CBLMapBlock = { (doc: [NSObject: AnyObject]!, emit: CBLMapEmitBlock!) in
                if let type:AnyObject = doc["TableType"] {
                    
                    emit(doc["TableType"], doc)
                    
                }
            }
            view.setMapBlock(mapBlock, version: "1.0")
        }
        
        query = view.createQuery()
        
        let keysArray:NSArray = ["2"]
        query.keys = keysArray  as! [AnyObject]
        
        
        queryEnumerator = query.run(&error)
        
        for obj  in queryEnumerator{
            
            let row = obj as! CBLQueryRow

            let locationModel = LocationData(dictionary: row.document.properties)
            
            
            locationsArray.addObject(locationModel)
            
            
        }
        //Sorting keys
        
        var tempDict:[String : [LocationData]] = [String : [LocationData]]()
        
        for location in locationsArray {
            
            let loc = location as! LocationData
            let category = loc.category as String!
            let keysArray:[String] = tempDict.keys.array
            
            if !contains(keysArray, category!) {
                var locArray = Array<LocationData>()
                locArray.append(loc)
                tempDict.updateValue(locArray, forKey: category)
            }else{
                var locArray:[LocationData] = tempDict[category]!
                locArray.append(loc)
                let sortedArray = locArray.sorted{ $0.name < $1.name} as Array
              
                tempDict.updateValue(sortedArray, forKey: category)
            }
        }
        
        var sortedKeysArray = tempDict.keys.array.sorted{ $0 < $1 }
        
        for(var i = 0 ; i < sortedKeysArray.count ; i++){
            
            let key:String = sortedKeysArray[i]
            let value = tempDict[key]
            
            let composeDict:[String:[LocationData]] = [key:value!]
            
            retArray.append(composeDict)
        }
        
        
        return retArray
        
    }
  
    
    func getSortedPhysicians()->([String:[Physician]]){
        
        var physiciansArray:[Physician] = getallPhysicians()
        
        var physiciansDict = Dictionary<String,[Physician]>()
        
        for physician in physiciansArray {
            
            let physicianData = physician as Physician
            let department:String = physicianData.dept as String
            
            if physiciansDict[department] == nil {
                var phyArray = Array<Physician>()
                phyArray.append(physicianData)
                physiciansDict.updateValue(phyArray, forKey: department)
                
            }else{
                
                var phyArray:[Physician] = physiciansDict[department]!
                phyArray.append(physicianData)
                let sortedArray = phyArray.sorted{ $0.fname < $1.fname} as Array
                physiciansDict.updateValue(phyArray, forKey: department)
                
            }
            
        }
        
        return physiciansDict
        
    }
    
    func getallPhysicians()->[Physician]{
    
    
        var physiciansArray:[Physician] = [Physician]()
    
        var error:NSError? = nil
    
        var queryEnumerator = CBLQueryEnumerator()
        var query:CBLQuery = self.database!.createAllDocumentsQuery()
    
        let view:CBLView = self.database!.viewNamed("view_by_ID")
    
        if view.mapBlock == nil {
            var mapBlock: CBLMapBlock = { (doc: [NSObject: AnyObject]!, emit: CBLMapEmitBlock!) in
        if let type:AnyObject = doc["TableType"] {
    
            emit(doc["TableType"], doc)
    
            }
        }
            view.setMapBlock(mapBlock, version: "1.0")
    
    }
    
        query = view.createQuery()
    
        let keysArray:NSArray = ["3"]
        query.keys = keysArray  as! [AnyObject]
    
    
        queryEnumerator = query.run(&error)
    
        for obj  in queryEnumerator{
    
            let row = obj as! CBLQueryRow
            let physician = Physician(dic: row.document.properties)
            physiciansArray.append(physician)
    
    
        }

        return physiciansArray
    
    }
    
    func getServicesData()->([ServiceModel]){
        
        var servicesArray:[ServiceModel] = [ServiceModel]()
        
        var error:NSError? = nil
        
        var queryEnumerator = CBLQueryEnumerator()
        var query:CBLQuery = self.database!.createAllDocumentsQuery()
        
        let view:CBLView = self.database!.viewNamed("view_by_ID")
        
        if view.mapBlock == nil {
            var mapBlock: CBLMapBlock = { (doc: [NSObject: AnyObject]!, emit: CBLMapEmitBlock!) in
                if let type:AnyObject = doc["TableType"] {
                    
                    emit(doc["TableType"], doc)
                    
                }
            }
            view.setMapBlock(mapBlock, version: "1.0")
        }
        
        query = view.createQuery()
        
        let keysArray:NSArray = ["1"]
        query.keys = keysArray  as! [AnyObject]
        
        
        queryEnumerator = query.run(&error)
        
        for obj  in queryEnumerator{
            
            let row = obj as! CBLQueryRow
            
            let service = ServiceModel(dic:row.document.properties)
            
            servicesArray.append(service)

        }
        let sortedArray = servicesArray.sorted{ $0.name < $1.name} as Array
        return sortedArray
    }

}

//
//  Physician.swift
//  Sjmo
//
//  Created by Ramesh Khanna on 5/19/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit
import CoreData
class Physician: NSObject {
    
    var fname:String
    var lname:String
    var middlename:String
    var degree:String
    var sex:String
    var email:String
    var photo:String
    var dept:String
    var officeAdd1a: String
    var officeAdd1b: String
    var office1city: String
    var office1state: String
    var office1zip: String
    var speciality2: String
    var board1: String
    var board2: String
    var board3: String
    var university1: String
    var fellowship1: String
    var fellowship2: String
    var internship1: String
    var office1name: String
    var office1tele1: String
    var office1tele2: String
    var office1fax: String
    var office2name: String
    var offAddr2a: String
    var offAddr2b: String
    var office2city: String
    var office2state: String
    var office2zip: String
    var office2tele1: String
    var office2tele2: String
    var office2fax: String
    var office3name: String
    var offAddr3a: String
    var offAddr3b: String
    var office3city: String
    var office3state: String
    var office3zip: String
    var office3tele1: String
    var office3tele2: String
    var office3fax: String
    var medicareid: String
    var membership: String
    
    init(dic:NSDictionary){
        
        self.fname = dic["First_name"] as! String
        self.lname = dic["Last_name"] as! String
        self.middlename = dic["Middle_initial"] as! String
        self.degree = dic["Degree"] as! String
        self.sex = dic["Sex"] as! String
        self.email = dic["EMailAddress"] as! String
        self.photo = dic["ma_photo"] as! String
        self.dept = dic["Specialty_1"] as! String
        self.officeAdd1a = dic["Office_1_address_1"] as! String
        self.officeAdd1b = dic["Office_1_address_2"] as! String
        self.office1city = dic["Office_1_city"] as! String
        self.office1state = dic["Office_1_state"] as! String
        self.office1zip = dic["Office_1_zip_code"] as! String
       // self.speciality1 = dic["Specialty_1"] as! String
        self.speciality2 = dic["Specialty_2"] as! String
        self.board1 = dic["Board_1"] as! String
        self.board2 = dic["Board_2"] as! String
        self.board3 = dic["Board_3"] as! String
        self.university1 = dic["University_1"] as! String
        self.fellowship1 = dic["Fellowship_1"] as! String
        self.fellowship2 = dic["Fellowship_2"] as! String
        self.internship1 = dic["Internship_1"] as! String
        self.office1name = dic["Office_1_name"] as! String
        self.office1tele1 = dic["Office_1_telephone_1"] as! String
        self.office1tele2 = dic["Office_1_telephone_2"] as! String
        self.office1fax = dic["Office_1_fax_number"] as! String
        self.office2name = dic["Office_2_name"] as! String
        self.offAddr2a = dic["Office_2_address_1"] as! String
        self.offAddr2b = dic["Office_2_address_2"] as! String
        self.office2city = dic["Office_2_city"] as! String
        self.office2state = dic["Office_2_state"] as! String
        self.office2zip = dic["Office_2_zip_code"] as! String
        self.office2tele1 = dic["Office_2_telephone_1"] as! String
        self.office2tele2 = dic["Office_2_telephone_2"] as! String
        self.office2fax = dic["Office_2_fax_number"] as! String
        self.office3name = dic["Office_3_name"] as! String
        self.offAddr3a = dic["Office_3_address_1"] as! String
        self.offAddr3b = dic["Office_3_address_2"] as! String
        self.office3city = dic["Office_3_city"] as! String
        self.office3state = dic["Office_3_state"] as! String
        self.office3zip = dic["Office_3_zip_code"] as! String
        self.office3tele1 = dic["Office_3_telephone_1"] as! String
        self.office3tele2 = dic["Office_3_telephone_2"] as! String
        self.office3fax = dic["Office_3_fax_number"] as! String
        self.medicareid = dic["ma_npi"] as! String
        // self.medicareid = dic["Medicare_ID"] as! String
        self.membership = dic["SJMH_med_staff_membership"] as! String

    }
    
     init(physicianEntity:NSManagedObject){
        
        self.fname = physicianEntity.valueForKey("fname") as! String
        self.lname = physicianEntity.valueForKey("lname") as! String
        self.middlename = physicianEntity.valueForKey("middlename") as! String
        self.degree = physicianEntity.valueForKey("degree") as! String
        self.sex = physicianEntity.valueForKey("sex") as! String
        
        self.email = physicianEntity.valueForKey("email") as! String
        self.photo = physicianEntity.valueForKey("photo") as! String
        self.dept = physicianEntity.valueForKey("dept") as! String
        self.officeAdd1a = physicianEntity.valueForKey("officeAdd1a") as! String
        
        self.officeAdd1b = physicianEntity.valueForKey("officeAdd1b") as! String
        self.office1city = physicianEntity.valueForKey("office1city") as! String
        self.office1state = physicianEntity.valueForKey("office1state") as! String
        self.office1zip = physicianEntity.valueForKey("office1zip") as! String
        self.speciality2 = physicianEntity.valueForKey("speciality2") as! String
        
        self.board1 = physicianEntity.valueForKey("board1") as! String
        self.board2 = physicianEntity.valueForKey("board2") as! String
        self.board3 = physicianEntity.valueForKey("board3") as! String
        self.university1 = physicianEntity.valueForKey("university1") as! String
        self.fellowship1 = physicianEntity.valueForKey("fellowship1") as! String
        
        self.fellowship2 = physicianEntity.valueForKey("fellowship2") as! String
        self.internship1 = physicianEntity.valueForKey("internship1") as! String
        self.office1name = physicianEntity.valueForKey("office1name") as! String
        self.office1tele1 = physicianEntity.valueForKey("office1tele1") as! String
        self.office1tele2 = physicianEntity.valueForKey("office1tele2") as! String
        
        self.office1fax = physicianEntity.valueForKey("office1fax") as! String
        self.office2name = physicianEntity.valueForKey("office2name") as! String
        self.offAddr2a = physicianEntity.valueForKey("offAddr2a") as! String
        self.offAddr2b = physicianEntity.valueForKey("offAddr2b") as! String
        self.office2city = physicianEntity.valueForKey("office2city") as! String
        
        self.office2state = physicianEntity.valueForKey("office2state") as! String
        self.office2zip = physicianEntity.valueForKey("office2zip") as! String
        self.office2tele1 = physicianEntity.valueForKey("office2tele1") as! String
        self.office2tele2 = physicianEntity.valueForKey("office2tele2") as! String
        self.office2fax = physicianEntity.valueForKey("office2fax") as! String
        
        self.office3name = physicianEntity.valueForKey("office3name") as! String
        self.offAddr3a = physicianEntity.valueForKey("offAddr3a") as! String
        self.offAddr3b = physicianEntity.valueForKey("offAddr3b") as! String
        self.office3city = physicianEntity.valueForKey("office3city") as! String
        self.office3state = physicianEntity.valueForKey("office3state") as! String
        
        self.office3zip = physicianEntity.valueForKey("office3zip") as! String
        self.office3tele1 = physicianEntity.valueForKey("office3tele1") as! String
        self.office3tele2 = physicianEntity.valueForKey("office3tele2") as! String
        self.office3fax = physicianEntity.valueForKey("office3fax") as! String
        self.medicareid = physicianEntity.valueForKey("medicareid") as! String
        self.membership = physicianEntity.valueForKey("membership") as! String
        

    }
    
    var name:String{
        get{
            let fName = trimCharacter(self.fname)
            let mName = trimCharacter(self.middlename)
            let lName = trimCharacter(self.lname)
            
            var appendStr = "\(fName) \(mName) \(lName)"
            
            return appendStr //condenseWhitespace(appendStr)
        }
    }
    
    var address:String{
        get{
            let off1Add1 = trimCharacter(self.officeAdd1a)
            let off1Add2 = trimCharacter(self.officeAdd1b)
            let city1 = trimCharacter(self.office1city)
            let state1 = trimCharacter(self.office1state)
            let zip1 = trimCharacter(self.office1zip)
            
            let off2Add1 = trimCharacter(self.offAddr2a)
            let off2Add2 = trimCharacter(self.offAddr2b)
            let city2 = trimCharacter(self.office2city)
            let state2 = trimCharacter(self.office2state)
            let zip2 = trimCharacter(self.office2zip)

            let off3Add1 = trimCharacter(self.offAddr3a)
            let off3Add2 = trimCharacter(self.offAddr3b)
            let city3 = trimCharacter(self.office3city)
            let state3 = trimCharacter(self.office3state)
            let zip3 = trimCharacter(self.office3zip)

            
            var appendStr = "\(off1Add1) \(off1Add2) \(city1) \(state1) \(zip1)\n\n\(off2Add1) \(off2Add2) \(city2) \(state2) \(zip2)\n\n\(off3Add1) \(off3Add2) \(city3) \(state3) \(zip3)"
            
            return appendStr //condenseWhitespace(appendStr)
        }
    }
    
    var telephone: String {
        get{
            let off1Tel1 = trimCharacter(self.office1tele1)
            let off1Tel2 = trimCharacter(self.office1tele2)
            let off2Tel1 = trimCharacter(self.office2tele1)
            let off2Tel2 = trimCharacter(self.office2tele2)
            let off3Tel1 = trimCharacter(self.office3tele1)
            let off3Tell2 = trimCharacter(self.office3tele2)
            
            var appendStr = "\(off1Tel1)\n\(off1Tel2)\n\(off2Tel1)\n\(off2Tel2)\n\(off3Tel1)\n\(off3Tell2)"
            
            return appendStr //condenseWhitespace(appendStr)

        }
    }
    
    var fax: String {
        get{
            let off1 = trimCharacter(self.office1fax)
            let off2 = trimCharacter(self.office2fax)
            let off3 = trimCharacter(self.office3fax)
            
           var appendStr = "\(off1)\n\(off2)\n\(off3)"
          
            if off2 != "NA" {
                
            if off3 != "NA"  {
                
            var appendStr = "\(off1)\n\(off2)\n\(off3)"
                
            }
            else {
                 var appendStr = "\(off1)\n\(off2)"
                }
            }
            else {
                 var appendStr = "\(off1)"
            }
            
            return appendStr //condenseWhitespace(appendStr)

        }
    }
    
 
    
    func getRequest()->(NSURLRequest){
        
        let plistPath = NSBundle.mainBundle().pathForResource("ConfigureList", ofType: "plist")
        let configDic:NSDictionary = NSDictionary(contentsOfFile: plistPath!)!
        let imageServerDic = configDic["ImageServer"] as! NSDictionary
        
        let username = imageServerDic["username"] as? String
        let password = imageServerDic["password"] as? String
        let userPassString = "\(username):\(password)"
        
        
        let encodingData = NSData.encode(userPassString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
        let authHeader = "Basic \(encodingData)"
        
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string:self.photoUrl)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 3.0)
        
        request.addValue(authHeader, forHTTPHeaderField: "Authorization")
        
        return request
    }
    //Removing two whiteSpaces
    
    func condenseWhitespace(string: String) -> String {
        let components = string.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter({!isEmpty($0)})
        return join(" ", components)
    }
    
    var photoUrl:String{
        
        get{
            var url:String = "http://65.182.173.47:8080/SJMO_ShellBatchComponent/secure/resources/"
            
            url += self.photo
            
            return url
        }
    
    }
    
    func trimCharacter(str:String)->(String){
        
        var retVal = str
        if  str == "NA" {
             retVal = ""
        }
        if str == " "{
            retVal = ""
        }
        retVal.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        return retVal
    }
    
    var firstLetter:String{
        
        get{
            
            let index: String.Index = advance(self.fname.startIndex, 1)
            let ss2:String = self.fname.substringToIndex(index)
            
            return ss2
        }

    }
    
}



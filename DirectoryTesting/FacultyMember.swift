//
//  FacultyMember.swift
//  DirectoryTesting
//
//  Created by Jeremiah Simmons on 2/25/17.
//  Copyright © 2017 Pattonville School District. All rights reserved.
//

import Foundation

class FacultyMember: CustomStringConvertible{
    
    
    /*
        Fields to be stored from CSV File
    */
    var fname: String, lname: String, long_desc: String, location: String, email: String, office1: String ,ext1: String, office2: String, ext2: String, office3: String, ext3: String
    
    /*
        Constants to represent the ranking order for the directory
    */
    static let PRINCIPAL: Int = 0, ASSOCIATE_PRINCIPAL: Int = 1, ASSISTANT_PRINCIPAL:Int = 2,
        TEACHER: Int = 3, SECRETARY: Int = 4, SUPPORT_STAFF: Int = 5
    
    /*
        Used for nice printing a FacultyMember
    */
    
    public var description: String { return fname + " " + lname + ", " + long_desc}
    
    
    /*
        Variables must be lazy because you don't want to set them until the other
        fields have been initialized
    */
    lazy var directoryKey: String = self.getSchoolByLocation(location: self.location)
    lazy var rank: Int = self.getRank()
    
    
  
    init(fname: String, lname: String ,long_desc: String ,location: String ,email: String,office1: String, ext1: String, office2: String, ext2: String, office3: String, ext3: String){
        self.fname = fname
        self.lname = lname
        self.long_desc = long_desc
        self.location = location
        self.email = email
        self.office1 = office1
        self.ext1 = ext1
        self.office2 = office2
        self.ext2 = ext2
        self.office3 = office3
        self.ext3 = ext3
    }
    

    
    convenience init(data: [String]) {
        self.init(
            fname: data[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            lname: data[1].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            long_desc: data[2].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            location: data[3].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            email: data[4].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            office1: data[5].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            ext1: data[6].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            office2: data[7].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            ext2: data[8].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            office3: data[9].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            ext3: data[10].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        )
    }
    
    func getSchoolByLocation(location: String) -> String{
        var school = ""
        switch(location){
        case "BRIDGEWAY ELEMENTARY":
            school = "BR"
        case "ROBERT DRUMMOND ELEMENTARY":
            school = "DR"
        case "LEARNING CENTER":
            fallthrough
        case "DISTRICT WIDE":
            school = "LC"
        case "HOLMAN MIDDLE SCHOOL":
            school = "HO"
        case "PATTONVILLE HEIGHTS":
            school = "HT"
        case "POSITIVE SCHOOL":
            fallthrough
        case "PATTONVILLE HIGH SCHOOL":
            school = "HS"
        case "PARKWOOD ELEMENTARY":
            school = "PW"
        case "ROSE ACRES ELEMENTARY":
            school = "RA"
        case "REMINGTON TRADITIONAL":
            school = "RT"
        case "WILLOW BROOK ELEMENTARY":
            school = "WB"
        default:
            school = "LC"
        }
        return school
    }
    
    func getRank() -> Int{
        if self.long_desc.contains("PRINCIPAL"){
            if self.long_desc.contains("ASSISTANT"){
                return FacultyMember.ASSISTANT_PRINCIPAL
            }else if self.long_desc.contains("ASSOCIATE"){
                return FacultyMember.ASSOCIATE_PRINCIPAL
            }else{
                return FacultyMember.PRINCIPAL
            }
        }else if self.long_desc.contains("TEACHER"){
            return FacultyMember.TEACHER
        }else if self.long_desc.contains("SECRETARY"){
            return FacultyMember.SECRETARY
        }else{
            return FacultyMember.SUPPORT_STAFF
        }
    }
    

    
}

//
//  main.swift
//  DirectoryTesting
//
//  Created by Jeremiah Simmons on 2/25/17.
//  Copyright © 2017 Pattonville School District. All rights reserved.
//

import Foundation

var directory = [String: [FacultyMember]]()

let filePath = "/Users/jeremiahsimmons/Desktop/Student_Directory.csv"
var data:String = ""
do{
    data = try String(contentsOfFile:filePath, encoding: String.Encoding.utf8)
}catch{
    print(error)
}
var directoryInfo: [String] = data.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).components(separatedBy: "\n")
directoryInfo.removeFirst()


for person in directoryInfo{
    var currPerson = FacultyMember(data: person.components(separatedBy: ","))
    if(directory.index(forKey: currPerson.directoryKey) == nil){
        directory[currPerson.directoryKey] = []
    }
    directory[currPerson.directoryKey]?.append(currPerson)
}

func sortFacultyMembers(first: FacultyMember, second: FacultyMember) -> Bool{
    if first.rank == second.rank{
        if first.long_desc == second.long_desc{
            if first.lname == second.lname{
                return first.fname.compare(second.fname).rawValue < 0
            }else{
                return first.lname.compare(second.lname).rawValue < 0
            }
        }else{
            return first.long_desc.compare(second.long_desc).rawValue < 0
        }
    }else{
        return first.rank < second.rank
    }
}

for school in directory.keys{
    directory[school] = directory[school]?.sorted(by: sortFacultyMembers)
}

for i in 0..<directory["HS"]!.count{
    let long:String = directory["HS"]![i].long_desc
    print(long.capitalized(with: NSLocale.current))
}


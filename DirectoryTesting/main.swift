//
//  main.swift
//  DirectoryTesting
//
//  Created by Jeremiah Simmons on 2/25/17.
//  Copyright © 2017 Pattonville School District. All rights reserved.
//

import Foundation

var directory = [String: [FacultyMember]]()

/*
    Replace filePath with wherever you have your csv file stored
*/

let filePath = "/Users/jeremiahsimmons/Desktop/Student_Directory.csv"
var data:String = ""
do{
    data = try String(contentsOfFile:filePath, encoding: String.Encoding.utf8)
}catch{
    print(error)
}

/*
    Strip off the white space from the end and then split on newline
    Ensures you don't get empty line at the end
*/
var directoryInfo: [String] = data.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).components(separatedBy: "\n")
directoryInfo.removeFirst()

/*
    Go through each line, create a new FacultyMember instance
    Check to see if the directory already has the appropriate key
    If not, create a new FacultyMember Array for that key
    Insert current FacultyMember into appropriate array
 */

for person in directoryInfo{
    var currPerson = FacultyMember(data: person.components(separatedBy: ","))
    if(directory.index(forKey: currPerson.directoryKey) == nil){
        directory[currPerson.directoryKey] = []
    }
    directory[currPerson.directoryKey]?.append(currPerson)
}


/*
    Function to sort FacultyMembers
    returns Bool for if the two parameters are in ascending order
    (True if they should remain in order first, second.  False if order should be second, first)
    Sorts by FacultyMember's:
    1. Rank
    2. Long Description
    3. Last Name
    4. First Name
 
*/
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

/*
    Go through each FacultyMember Array and sort it
*/
for school in directory.keys{
    directory[school] = directory[school]?.sorted(by: sortFacultyMembers)
}

/*
    Just an example to show how you can take text from DIRECTORY VERSION to Directory Version
*/
for i in 0..<directory["HS"]!.count{
    print(directory["HS"]![i].description.capitalized(with: NSLocale.current))
}


//
//  person.swift
//  SQLiteBegining
//
//  Created by ArdaSisli on 30.12.2021.
//

import Foundation
class Persons {
    var person_id:Int?
    var person_name:String?
    var person_age:Int?
    
    init() {}
    
    init(person_id:Int,person_name:String,person_age:Int) {
        self.person_id = person_id
        self.person_name = person_name
        self.person_age = person_age
    }
}

//
//  PersonDao.swift
//  SQLiteBegining
//
//  Created by ArdaSisli on 30.12.2021.
//

import Foundation

class Persondao {
    let db:FMDatabase?
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let DataBase = URL(fileURLWithPath: targetPath).appendingPathComponent("Persons.sqlite")
        db = FMDatabase(path: DataBase.path)
    }
    
    func AddPerson(person_name:String,person_age:Int) {
        db?.open()
        do {
            try db!.executeUpdate("INSERT INTO persons (person_name,person_age)  VALUES (?,?)", values:[person_name,person_age])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func GetAllContacts()->[Persons] {
        var list = [Persons]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT*FROM persons", values: nil)
            while rs.next() {
            let  person = Persons(person_id: Int(rs.string(forColumn: "person_id"))!
                        , person_name: rs.string(forColumn: "person_name")!
                        , person_age: Int(rs.string(forColumn: "person_age"))!)
                list.append(person)
            }
        
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        return list
    }
}

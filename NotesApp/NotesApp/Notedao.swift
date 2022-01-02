//
//  Notedao.swift
//  NotesApp
//
//  Created by ArdaSisli on 2.01.2022.
//

import Foundation

class Notedao {
    let db:FMDatabase?
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let DataBase = URL(fileURLWithPath: targetPath).appendingPathComponent("notlar.sqlite")
        db = FMDatabase(path: DataBase.path)
    }
    
    func GetAllTheNotes()->[Notes] {
        var list = [Notes]()
        db?.open()
        do {
       let rs = try db!.executeQuery("SELECT * FROM notlar", values: nil)
            while rs.next() {
                let note = Notes(not_id: Int(rs.string(forColumn: "not_id"))!
                                 , ders_adi: rs.string(forColumn: "ders_adi")!
                                 , not1: Int(rs.string(forColumn: "not1"))!
                                 , not2: Int(rs.string(forColumn: "not2"))!)
                list.append(note)
            }
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
        return list
    }
    
    func AddNote(ders_adi:String,not1:Int,not2:Int) {
        db?.open()
        do {
            try db!.executeUpdate("INSERT INTO notlar (ders_adi,not1,not2) VALUES (?,?,?) " , values: [ders_adi,not1,not2])
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func UpdateNote(not_id:Int,ders_adi:String,not1:Int,not2:Int) {
        db?.open()
        do {
            try db!.executeUpdate("UPDATE notlar SET ders_adi = ?,not1 = ?, not2 = ? WHERE not_id = ? " , values: [ders_adi,not1,not2,not_id])
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func DeleteNote(not_id:Int) {
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM notlar WHERE  not_id = ?" , values: [not_id])
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
}

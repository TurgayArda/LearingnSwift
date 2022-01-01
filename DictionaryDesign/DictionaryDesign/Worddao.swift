//
//  Worddao.swift
//  DictionaryDesign
//
//  Created by ArdaSisli on 1.01.2022.
//

import Foundation
class Worddao {
    let db:FMDatabase?
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let DataBase = URL(fileURLWithPath: targetPath).appendingPathComponent("sozluk.sqlite")
        db = FMDatabase(path: DataBase.path)
    }
    
    func allDictionaryGet()->[Kelimeler] {
        var list = [Kelimeler]()
        db?.open()
        do {
       let rs = try db!.executeQuery("SELECT * FROM kelimeler", values: nil)
            while rs.next() {
             let word = Kelimeler(kelime_id: Int(rs.string(forColumn: "kelime_id"))!
                          , ingilizce: rs.string(forColumn: "ingilizce")!
                          , turkce: rs.string(forColumn: "turkce")!)
                list.append(word)
            }
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
        return list
    }
    
    func DoSearch(ingilizce:String)->[Kelimeler] {
        var list = [Kelimeler]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT*FROM kelimeler WHERE ingilizce like '%\(ingilizce)%'", values: nil)
            while rs.next() {
                let word = Kelimeler(kelime_id: Int(rs.string(forColumn: "kelime_id"))!
                                     , ingilizce: rs.string(forColumn: "ingilizce")!
                                     , turkce: rs.string(forColumn: "turkce")!)
                list.append(word)
            }
        }catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
}

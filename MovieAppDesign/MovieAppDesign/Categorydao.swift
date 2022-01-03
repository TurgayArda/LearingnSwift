//
//  Categorydao.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import Foundation


class Categoryrdao {
    
    let db:FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("filmler.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func GettAllTheCategories()->[Categories] {
        var list = [Categories]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT*FROM kategoriler" , values: nil)
            while rs.next() {
                let category = Categories(kategori_id: Int(rs.string(forColumn: "kategori_id"))!
                                          , kategori_ad: rs.string(forColumn: "kategori_ad")!)
                list.append(category)
            }
        } catch  {
            print(error.localizedDescription)
        }
        return list
    }
}


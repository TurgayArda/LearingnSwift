//
//  Moviedao.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import Foundation

class Filmlerdao {
    
    let db:FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("filmler.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func GetAllTheMovies(kategori_id:Int)->[Movies] {
        var list = [Movies]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT*FROM filmler,yonetmenler,kategoriler WHERE filmler.kategori_id = kategoriler.kategori_id and filmler.yonetmen_id = yonetmenler.yonetmen_id and filmler.kategori_id = ?", values: [kategori_id])
            while rs.next() {
                let arda = Categories(kategori_id: Int(rs.string(forColumn: "kategori_id"))!
                                          , kategori_ad: rs.string(forColumn: "kategori_ad")!)
                
                let turgay = Directors(yonetmen_id: Int(rs.string(forColumn: "yonetmen_id"))!
                                         , yonetmen_ad: rs.string(forColumn: "yonetmen_ad")!)
                
             let movie = Movies(yonetmen: turgay
                                , kategori: arda
                                , film_id: Int(rs.string(forColumn: "film_id"))!
                                , film_ad: rs.string(forColumn: "film_ad")!
                                , film_yil: Int(rs.string(forColumn: "film_yil"))!
                                , film_resim: rs.string(forColumn: "film_resim")!)
                list.append(movie)
            }
        } catch  {
            print(error.localizedDescription)
        }
        return list
    }
       
}

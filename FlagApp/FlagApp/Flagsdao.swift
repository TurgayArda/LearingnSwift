//
//  Flagsdao.swift
//  FlagApp
//
//  Created by ArdaSisli on 31.12.2021.
//

import Foundation
class Flagsdao {
    let db:FMDatabase?
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let DataBase = URL(fileURLWithPath: targetPath).appendingPathComponent("FlagApp.sqlite")
        db = FMDatabase(path: DataBase.path)
    }
    
    func RandomBring5() -> [Flags] {
        var list = [Flags]()
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM Bayraklar ORDER BY RANDOM() LIMIT  5", values: nil)
            while(rs.next()) {
                let flag = Flags(bayrak_id: Int(rs.string(forColumn: "bayrak_id"))!
                                 , bayrak_ad: rs.string(forColumn: "bayrak_ad")!
                                 , bayrak_resim: rs.string(forColumn: "bayrak_resim")!)
                list.append(flag)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func RandomBring3(bayrak_id:Int) -> [Flags] {
        var list = [Flags]()
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM Bayraklar WHERE bayrak_id != ? ORDER BY RANDOM() LIMIT  3", values: [bayrak_id])
            while(rs.next()) {
                let flag = Flags(bayrak_id: Int(rs.string(forColumn: "bayrak_id"))!
                                 , bayrak_ad: rs.string(forColumn: "bayrak_ad")!
                                 , bayrak_resim: rs.string(forColumn: "bayrak_resim")!)
                list.append(flag)
            }
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
}

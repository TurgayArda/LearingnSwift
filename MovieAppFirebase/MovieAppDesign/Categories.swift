//
//  Categories.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import Foundation

class Categories{
    var kategori_id:String?
    var kategori_ad:String?
    
    init() {}
    
    init(kategori_id:String,kategori_ad:String) {
        self.kategori_id = kategori_id
        self.kategori_ad = kategori_ad
    }
}

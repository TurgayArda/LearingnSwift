//
//  Movies.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import Foundation

class Movies {
    var yonetmen:Directors?
    var kategori:Categories?
    var film_id:Int?
    var film_ad:String?
    var film_yil:Int?
    var film_resim:String?
  
    
    
    init() {}
    
    init(yonetmen:Directors,kategori:Categories,film_id:Int,film_ad:String,film_yil:Int,film_resim:String) {
        self.yonetmen = yonetmen
        self.kategori = kategori
        self.film_id = film_id
        self.film_ad = film_ad
        self.film_resim = film_resim
        self.film_yil = film_yil
    }
}

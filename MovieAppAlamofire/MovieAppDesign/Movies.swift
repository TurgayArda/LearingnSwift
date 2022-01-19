//
//  Movies.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import Foundation

class Movies:Codable {
    var yonetmen:Directors?
    var kategori:Categories?
    var film_id:String?
    var film_ad:String?
    var film_yil:String?
    var film_resim:String?
  
    
    
    init() {}
    
    init(yonetmen:Directors,kategori:Categories,film_id:String,film_ad:String,film_yil:String,film_resim:String) {
        self.yonetmen = yonetmen
        self.kategori = kategori
        self.film_id = film_id
        self.film_ad = film_ad
        self.film_resim = film_resim
        self.film_yil = film_yil
    }
}

//
//  Movies.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import Foundation

class Movies {
    var yonetmen_ad:String?
    var kategori_ad:String?
    var film_id:String?
    var film_ad:String?
    var film_yil:Int?
    var film_resim:String?
  
    
    
    init() {}
    
    init(yonetmen_ad:String,kategori_ad:String,film_id:String,film_ad:String,film_yil:Int,film_resim:String) {
        self.yonetmen_ad = yonetmen_ad
        self.kategori_ad = kategori_ad
        self.film_id = film_id
        self.film_ad = film_ad
        self.film_resim = film_resim
        self.film_yil = film_yil
    }
}

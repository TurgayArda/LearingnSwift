//
//  Costant.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 13.01.2022.
//

import Foundation
//Base url
class Constant {
    
}

extension Constant {
    class MovieConstant {
        static let filmAd = "film_ad"
        static let filmyil = "film_yil"
        static let KategoriAd = "kategori_ad"
        static let yonetmenAd = "yonetmen_ad"
        static let filmResim = "film_resim"
    }
    
    class NetworkConstant {
        private static let baseUrl = "http://kasimadalan.pe.hu"
        private static let filmResimler = "/filmler/resimler/"
        
        static func createMovieImage(id: String) -> String {
            return baseUrl + filmResimler + "\(id).png"
        }
    }
   //Restfull api

}

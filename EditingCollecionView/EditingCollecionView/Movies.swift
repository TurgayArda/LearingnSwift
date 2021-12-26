//
//  Movies.swift
//  EditingCollecionView
//
//  Created by ArdaSisli on 26.12.2021.
//

import Foundation
import UIKit

class Movies {
    var MovieName:String?
    var MoviePrice:String?
    var MovieImageName:String?
    
    init(MovieName:String,MoviePrice:String,MovieImageName:String) {
        self.MovieImageName = MovieImageName
        self.MovieName = MovieName
        self.MoviePrice = MoviePrice
        
    }
    
    init() {}
}

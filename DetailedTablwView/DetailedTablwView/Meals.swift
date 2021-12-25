//
//  Meals.swift
//  DetailedTablwView
//
//  Created by ArdaSisli on 26.12.2021.
//

import Foundation

class Meals {
    var FoodName:String?
    var FoodImageName:String?
    var FoodPrice:Double?
    
    init () {}
    
    init(FoodName:String , FoodImageName:String , FoodPrice:Double) {
        self.FoodImageName  = FoodImageName
        self.FoodPrice      = FoodPrice
        self.FoodName       = FoodName
    }
}

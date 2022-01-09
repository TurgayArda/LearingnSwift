//
//  Dictionary.swift
//  DictionaryDesign2
//
//  Created by ArdaSisli on 7.01.2022.
//

import Foundation

class Dictionary {
    var kelime_id:String?
    var ingilizce:String?
    var turkce:String?
    
    init() {}
    
    init(kelime_id:String,ingilizce:String,turkce:String) {
        self.kelime_id = kelime_id
        self.ingilizce = ingilizce
        self.turkce = turkce
    }
}

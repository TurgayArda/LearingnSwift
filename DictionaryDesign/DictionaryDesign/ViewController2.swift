//
//  ViewController2.swift
//  DictionaryDesign
//
//  Created by ArdaSisli on 1.01.2022.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var English: UILabel!
    @IBOutlet weak var Turkce: UILabel!
    
    var message:Kelimeler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let come = message {
            if let e = come.ingilizce {
                if let t = come.turkce {
                    English.text = "Engish: \(e)"
                    Turkce.text =  "Turkce: \(t)"
                }
            }
        }
    }
}

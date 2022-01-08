//
//  ViewController2.swift
//  DictionaryDesign2
//
//  Created by ArdaSisli on 7.01.2022.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var ELabel: UILabel!
    @IBOutlet weak var TLabel: UILabel!
    
    var messega:Dictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let e = messega?.ingilizce , let t = messega?.turkce {
            ELabel.text = e
            TLabel.text = t
        }
        
    }
    

   

}

//
//  ViewController4.swift
//  Uygulama
//
//  Created by ArdaSisli on 16.12.2021.
//

import UIKit

class ViewController4: UIViewController {
    
    @IBOutlet weak var Sonuc: UILabel!
    
    @IBOutlet weak var Resim: UIImageView!
    var geliyor2:Bool?
    var geliyor3:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let temp = geliyor2 {
            print(temp)
        }
        self.navigationItem.hidesBackButton = true
        if geliyor3 == true {
            Resim.image = UIImage(named: "Mutlu")
            Sonuc.text = "Kazandindiniz"
        }else{
            
        }

    }
    
    
    @IBAction func Click(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

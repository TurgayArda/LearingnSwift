//
//  ViewController3.swift
//  Uygulama
//
//  Created by ArdaSisli on 16.12.2021.
//

import UIKit

class ViewController3: UIViewController {
    
    @IBOutlet weak var Hak: UILabel!
    
    @IBOutlet weak var Yardim: UILabel!
    
    @IBOutlet weak var DegerGir: UITextField!
    var geliyor:Bool?
    var KalanHak = 5
    var RasgeleSayi:Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        Yardim.isHidden = true
        RasgeleSayi = Int.random(in: 0...100)
        if let temp = RasgeleSayi {
            print(temp)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Bool {
            let gidilecekVC = segue.destination as! ViewController4
            gidilecekVC.geliyor3 = temp
        }
    }
    
    
    @IBAction func Click(_ sender: Any) {
        Yardim.isHidden = false
        KalanHak -= 1
        if let sonuc = RasgeleSayi {
            if let deger = DegerGir.text {
                if let veri = Int(deger) {
                    if veri == sonuc {
                        let donus = true
                        performSegue(withIdentifier: "3To4", sender: donus)
                    }
                    if veri != sonuc {
                        if veri < sonuc {
                            Yardim.text = "Arttir"
                            Hak.text = "Kalan Hak : \(KalanHak)"
                        }
                        if veri > sonuc {
                            Yardim.text = "Azalt"
                            Hak.text = "Kalan Hak : \(KalanHak)"
                        }
                        if KalanHak == 0 {
                            let donus = false
                            performSegue(withIdentifier: "3To4", sender: donus)
                        }
                    }
                }
            }
        }
    }
    

}

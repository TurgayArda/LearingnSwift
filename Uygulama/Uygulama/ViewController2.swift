//
//  ViewController2.swift
//  Uygulama
//
//  Created by ArdaSisli on 16.12.2021.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var Gosterge: UILabel!
    
    @IBOutlet weak var Yardim: UILabel!
    
    @IBOutlet weak var DegerGir: UITextField!
    
    var KalanHak = 3
    var Rastgelesayi:Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Rastgelesayi  = Int.random(in: 0...10)
        if let temp = Rastgelesayi {
            print(temp)
        }
        Yardim.isHidden = true
        self.navigationItem.hidesBackButton = true

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gelen = sender as? Bool {
            if gelen == true {
               let gidilecekVc = segue.destination as! ViewController3
               gidilecekVc.geliyor = gelen
            }
            if gelen == false {
                let gidilecekVc2 = segue.destination as! ViewController4
                gidilecekVc2.geliyor2 = gelen
            }
         }
      }
    
    
    @IBAction func Click(_ sender: Any) {
        Yardim.isHidden = false
        if let rast = Rastgelesayi {
        if let sonuc = DegerGir.text {
            if let veri = Int(sonuc) {
        if KalanHak != 0 {
            KalanHak -= 1
            if veri == rast {
                KalanHak += 1 
                let karar = true
                performSegue(withIdentifier: "2To3", sender: karar)
            }
            else if veri < rast {
                Gosterge.text = "Kalan Hak : \(KalanHak)"
                Yardim.text   = "Arttir"
               
            }
            else if veri > rast {
                Gosterge.text = "Kalan Hak : \(KalanHak)"
                Yardim.text   = "Azalt"
            
            }
            }else{
                let karar = false
            performSegue(withIdentifier: "2To4", sender: karar)
          }
        }
      }
    }
  }
}

//
//  ViewController3.swift
//  Uygulama2
//
//  Created by ArdaSisli on 18.12.2021.
//

import UIKit

class ViewController3: UIViewController {
    
    
    @IBOutlet weak var Etiket: UILabel!
    @IBOutlet weak var Resim: UIImageView!
    var gelen:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let temp = gelen {
            if temp == "Balikligol" {
                Etiket.text = "Balikligol,rivayete göre Hz. İbrahim ateşe atıldıktan sonra, bir mucize gerçekleşir ve etraf güllük gülistanlık olur. Bu mucizenin gerçekleştiği mekânın Balıklıgöl ve çevresi olduğuna inanılır."
                Resim.image = UIImage(named: "Balikligol")
                self.navigationItem.title = "Balikligol"
            }
            if temp == "Gobeklitepe" {
                Etiket.text = "Arkeolojik bir mevkii olarak ilk kez 1963 yılında, Türk ve Amerikan bilim adamlarının yaptığı bir yüzey araştırması sırasında tespit edilmistir.Göbekli Tepe’de 4 tabaka açığa çıkartılmıştır. En üstteki I. Tabaka, tarım yapılan yüzey dolgusu olup, geriye kalan 3 tabaka ise Çanak Çömleksiz Neolitik Dönem’e tarihlenmektedir."
                Resim.image = UIImage(named: "Gobeklitepe")
                self.navigationItem.title = "Gobeklitepe"
            }
        }
      
    }
    

   

}

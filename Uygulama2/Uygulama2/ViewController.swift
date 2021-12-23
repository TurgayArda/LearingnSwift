//
//  ViewController.swift
//  Uygulama2
//
//  Created by ArdaSisli on 17.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func BilgiAl(_ sender: Any) {
        
        let Alert = UIAlertController(title: "Hangi Tarihi Mekan", message: "Lutfen Birini Seciniz", preferredStyle: .alert)
        let Mekan1 = UIAlertAction(title: "Balikligol", style: .destructive)  { action in
            let isim = "Balikligol"
            self.performSegue(withIdentifier: "1To3", sender: isim)
        }
        let Mekan2 = UIAlertAction(title: "Gobeklitepe", style: .destructive) { action in
            let isim = "Gobeklitepe"
            self.performSegue(withIdentifier: "1To3", sender: isim)
        }
        
        Alert.addAction(Mekan1)
        Alert.addAction(Mekan2)
        self.present(Alert, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? String {
        let gidilecekVc = segue.destination as! ViewController3
            gidilecekVc.gelen = temp
        }
    }    
}


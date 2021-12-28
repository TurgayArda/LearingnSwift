//
//  ViewController.swift
//  UserDefaultLoginApp
//
//  Created by ArdaSisli on 27.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    let d = UserDefaults.standard
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let UN = d.string(forKey: "username") ?? "empty"
        let P = d.string(forKey: "Password") ?? "empty"
        if UN != "empty" && P != "empty" {
            performSegue(withIdentifier: "1To2", sender: nil)
        }
    
    }
    
    @IBAction func Login(_ sender: Any) {
        
        if let UN = UserName.text ,  let P = Password.text {
            if UN == "arda" && P == "1997" {
                d.set(UN, forKey: "username")
                d.set(P, forKey: "Password")
            performSegue(withIdentifier: "1To2", sender: nil)
            }else{
                print("Hatali giris")
            }
        }
    }
}

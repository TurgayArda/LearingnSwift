//
//  AddPersonViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit
import Firebase

class AddPersonViewController: UIViewController {
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Phone: UITextField!
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func AddClick(_ sender: Any) {
        if let N = Name.text , let P = Phone.text {
                AddPerson(kisi_ad: N, kisi_tel: P)
        }
        Name.text = ""
        Phone.text = ""
    }
    
    func AddPerson(kisi_ad:String,kisi_tel:String) {
        let dic:[String:Any] = ["kisi_ad":kisi_ad,"kisi_tel":kisi_tel]
        let newref = ref.child("kisiler").childByAutoId()
        newref.setValue(dic)

    }
    
  
}

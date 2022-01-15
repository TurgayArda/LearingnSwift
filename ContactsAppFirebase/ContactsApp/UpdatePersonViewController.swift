//
//  UpdatePersonViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit
import Firebase

class UpdatePersonViewController: UIViewController {
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Phone: UITextField!
    
    var message:Persons?
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        if let N = message?.kisi_ad , let  P = message?.kisi_tel {
            Name.text = N
            Phone.text = P
        }
        
    }
    

    @IBAction func UpdateClick(_ sender: Any) {
        if let N = Name.text ,  let  P = Phone.text , let ID = message?.kisi_id {
            UpdatePerson(kisi_id: ID, kisi_ad: N, kisi_tel: P)
        }
        Name.text = ""
        Phone.text = ""
    }
    
    func UpdatePerson(kisi_id:String,kisi_ad:String,kisi_tel:String) {
        let dic:[String:Any] = ["kisi_ad":kisi_ad,"kisi_tel":kisi_tel]
        ref.child("kisiler").child(kisi_id).updateChildValues(dic)


    }
    
    

}

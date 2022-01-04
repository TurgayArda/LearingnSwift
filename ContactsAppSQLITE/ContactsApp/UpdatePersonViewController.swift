//
//  UpdatePersonViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit

class UpdatePersonViewController: UIViewController {
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Phone: UITextField!
    var message:Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func UpdateClick(_ sender: Any) {
        if let N = Name.text , let P = Phone.text , let id = message?.kisi_id {
            Contactsdao().UpdatePerson(kisi_id: id, kisi_ad: N, kisi_tel: P)
        }
        Name.text = " "
        Phone.text = " "
    }
}

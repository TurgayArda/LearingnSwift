//
//  AddPersonViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit

class AddPersonViewController: UIViewController {
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Phone: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func AddClick(_ sender: Any) {
        if let n = Name.text , let t = Phone.text {
        Contactsdao().AddPerson(kisi_ad: n, kisi_tel: t)
        }
        Name.text = " "
        Phone.text = " "
    }
}

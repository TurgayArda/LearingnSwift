//
//  DetailPersonViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit

class DetailPersonViewController: UIViewController {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Phone: UILabel!
    
    var message:Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let N = message?.kisi_ad , let P = message?.kisi_tel {
            Name.text = N
            Phone.text = P
        }
        
    }
    

   

}

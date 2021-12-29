//
//  ViewController4.swift
//  ContactsAppDesign
//
//  Created by ArdaSisli on 29.12.2021.
//

import UIKit

class ViewController4: UIViewController {

    @IBOutlet weak var UserNameL: UILabel!
    @IBOutlet weak var PassawordL: UILabel!
    
    var inComing:Persons?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let temp = inComing {
            UserNameL.text = temp.person_name
            PassawordL.text = temp.person_phone
        }
    }
    


}

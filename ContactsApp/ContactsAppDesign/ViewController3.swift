//
//  ViewController3.swift
//  ContactsAppDesign
//
//  Created by ArdaSisli on 29.12.2021.
//

import UIKit

class ViewController3: UIViewController {

    @IBOutlet weak var UserNameV3: UITextField!
    
    @IBOutlet weak var PassawordV3: UITextField!
    
    let context = appDelegate.persistentContainer.viewContext
    
    var inComing:Persons?
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        if let temp = inComing {
            UserNameV3.text = temp.person_name
            PassawordV3.text = temp.person_phone
        }
        
    }
    
    @IBAction func EditAction(_ sender: Any) {
        
        if let k = inComing , let name = UserNameV3.text , let phone = PassawordV3.text {
            
            k.person_name = name
            k.person_phone = phone
        }
        appDelegate.saveContext()
        UserNameV3.text = " "
        PassawordV3.text = " "
    }
    
    

}

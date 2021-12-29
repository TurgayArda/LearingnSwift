//
//  ViewController2.swift
//  ContactsAppDesign
//
//  Created by ArdaSisli on 29.12.2021.
//

import UIKit

class ViewController2: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var UserNameV: UITextField!
    
    @IBOutlet weak var PassawordV: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    @IBAction func AddV(_ sender: Any) {
        if let name = UserNameV.text , let phone = PassawordV.text {
            
                let person =  Persons(context: context)
                person.person_name = name
                person.person_phone = phone
                
                appDelegate.saveContext()
            
            
            UserNameV.text = " "
            PassawordV.text = " "
        }
    }
}

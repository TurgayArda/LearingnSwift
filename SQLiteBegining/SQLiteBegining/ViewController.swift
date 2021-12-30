//
//  ViewController.swift
//  SQLiteBegining
//
//  Created by ArdaSisli on 30.12.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DataCopy()
        Persondao().AddPerson(person_name: "Turgay", person_age: 24)
        let ComeList = Persondao().GetAllContacts()
        for k in ComeList {
            print("ID: \(k.person_id!) - Name: \(k.person_name!) - Age: \(k.person_age!)")
        }
    }
    
    func DataCopy() {
    let bundlePath = Bundle.main.path(forResource: "Persons", ofType: ".sqlite")
    let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let filemenager = FileManager.default
    let copyPath = URL(fileURLWithPath: targetPath).appendingPathComponent("Persons.sqlite")
    if filemenager.fileExists(atPath: copyPath.path) {
        print("veri zaten var")
        
    }else{
        
        do {
            if let temp = bundlePath {
        try filemenager.copyItem(atPath: temp , toPath: copyPath.path)
            }
        }catch{
            print(error)
            
            }
        }
    }
}


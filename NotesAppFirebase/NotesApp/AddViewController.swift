//
//  AddViewController.swift
//  NotesApp
//
//  Created by ArdaSisli on 10.01.2022.
//

import UIKit
import Firebase

class AddViewController: UIViewController {
    
    @IBOutlet weak var Lesson: UITextField!
    @IBOutlet weak var Note1: UITextField!
    @IBOutlet weak var Note2: UITextField!
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        Lesson.placeholder = "Lesson"
        Note1.placeholder = "Note1"
        Note2.placeholder = "Note2"
        
        
        
    
    }
    
    @IBAction func AddButton(_ sender: Any) {
        if let L = Lesson.text , let N1 = Note1.text , let N2 = Note2.text {
           if let ON1 = Int(N1) , let ON2 = Int(N2) {
                AddNotes(ders_adi: L, not1: ON1, not2: ON2)
            }
        }
        Lesson.text = ""
        Note1.text = ""
        Note2.text = ""
    }
    
    func AddNotes(ders_adi:String,not1:Int,not2:Int) {
        let dict:[String:Any] = ["ders_adi":ders_adi,"not1":not1,"not2":not2]
        let NewRef = ref.child("notlar").childByAutoId()
        NewRef.setValue(dict)
    }
    
}

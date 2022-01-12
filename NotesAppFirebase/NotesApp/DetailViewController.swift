//
//  DetailViewController.swift
//  NotesApp
//
//  Created by ArdaSisli on 10.01.2022.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    
    @IBOutlet weak var Lesson: UITextField!
    @IBOutlet weak var Note1: UITextField!
    @IBOutlet weak var Note2: UITextField!
    var ref:DatabaseReference!
    var message:Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        Lesson.placeholder = "Lesson"
        Note1.placeholder = "Note1"
        Note2.placeholder = "Note2"
        
        if let L = message?.ders_adi , let N1 = message?.not1 , let N2 = message?.not2 {
            Lesson.text = L
            Note1.text = "\(N1)"
            Note2.text = "\(N2)"
        }
        
      
    }
    
    @IBAction func DeleteClick(_ sender: Any) {
        if let ID = message?.not_id {
            DeleteNotes(not_id: ID)
        }
        Lesson.text = ""
        Note1.text = ""
        Note2.text = ""
   
    }
    
    @IBAction func EditClick(_ sender: Any) {
        if let L = Lesson.text , let N1 = Note1.text , let N2 = Note2.text , let ID = message?.not_id {
            if let ON1 = Int(N1) , let ON2 = Int(N2) {
                UpdateNotes(ders_adi: L, not1: ON1, not2: ON2, not_id: ID)
            }
        }
        Lesson.text = ""
        Note1.text = ""
        Note2.text = ""
    }
    
    func UpdateNotes(ders_adi:String,not1:Int,not2:Int,not_id:String) {
        let dict:[String:Any] = ["ders_adi":ders_adi,"not1":not1,"not2":not2]
        ref.child("notlar").child(not_id).updateChildValues(dict)
    }
    
    func DeleteNotes(not_id:String) {
        ref.child("notlar").child(not_id).removeValue()
    }
    
    
}

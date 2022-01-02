//
//  ViewController3.swift
//  NotesApp
//
//  Created by ArdaSisli on 2.01.2022.
//

import UIKit

class ViewController3: UIViewController {
    
    @IBOutlet weak var Lesson: UITextField!
    @IBOutlet weak var Note1: UITextField!
    @IBOutlet weak var Note2: UITextField!
    
    var message:Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let L = message?.ders_adi , let n1 = message?.not1 , let n2 = message?.not2 {
            Lesson.text = L
            Note1.text = "\(n1)"
            Note2.text = "\(n2)"
        }
     
    }
    
    
    @IBAction func TrashClick(_ sender: Any) {
        if let temp = message?.not_id {
        Notedao().DeleteNote(not_id: temp)
        }
    }
    
    @IBAction func EditClick(_ sender: Any) {
        if let L = Lesson.text, let n1 = Note1.text , let n2 = Note2.text , let i = message?.not_id {
            if let On1 = Int(n1) , let On2 = Int(n2) {
            Notedao().UpdateNote(not_id: i , ders_adi: L, not1: On1, not2: On2)
            }
        }
    }
}

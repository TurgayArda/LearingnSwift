//
//  ViewController2.swift
//  NotesApp
//
//  Created by ArdaSisli on 2.01.2022.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var Lesson: UITextField!
    @IBOutlet weak var Not1: UITextField!
    @IBOutlet weak var Note2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func AddClick(_ sender: Any) {
        if let temp = Lesson.text , let temp2 = Not1.text , let temp3 = Note2.text {
            if let n1 = Int(temp2) , let n2 = Int(temp3) {
                Notedao().AddNote(ders_adi: temp, not1: n1, not2: n2)
            }
        }
        Lesson.text = " "
        Not1.text = " "
        Note2.text = " "
    }
}

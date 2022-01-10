//
//  AddViewController.swift
//  NotesApp
//
//  Created by ArdaSisli on 10.01.2022.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var Lesson: UITextField!
    @IBOutlet weak var Note1: UITextField!
    @IBOutlet weak var Note2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Lesson.placeholder = "Lesson"
        Note1.placeholder = "Note1"
        Note2.placeholder = "Note2"
        
        
    
    }
    
    @IBAction func AddButton(_ sender: Any) {
        
        if let L = Lesson.text , let N1 = Note1.text , let N2 = Note2.text {
            if let ON1 = Int(N1) , let ON2 = Int(N2) {
             AddNote(ders_adi: L, not1: ON1, not2: ON2)
            }
        }
        Lesson.text = ""
        Note1.text = ""
        Note2.text = ""
    }
        
    func AddNote(ders_adi:String,not1:Int,not2:Int){
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/insert_not.php")!)
        request.httpMethod = "POST"
        let postString = "ders_adi=\(ders_adi)&not1=\(not1)&not2=\(not2)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data,response,error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]{
                    print(json)
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

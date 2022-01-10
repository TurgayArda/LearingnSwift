//
//  DetailViewController.swift
//  NotesApp
//
//  Created by ArdaSisli on 10.01.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var Lesson: UITextField!
    @IBOutlet weak var Note1: UITextField!
    @IBOutlet weak var Note2: UITextField!
    
    var message:Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Lesson.placeholder = "Lesson"
        Note1.placeholder = "Note1"
        Note2.placeholder = "Note2"
        
        if let L = message?.ders_adi , let N1 = message?.not1 , let N2 = message?.not2 {
            Lesson.text = L
            Note1.text = N1
            Note2.text = N2
            
        }
      
    }
    
    @IBAction func DeleteClick(_ sender: Any) {
        if let K = message?.not_id {
            if let OK = Int(K) {
                DeleteNote(not_id: OK)
            }
        }
        Lesson.text = ""
        Note2.text =  ""
        Note1.text = ""
    }
    @IBAction func EditClick(_ sender: Any) {
        
        if let L = Lesson.text , let N1 = Note1.text , let N2 = Note2.text , let K = message?.not_id {
            if let OK = Int(K) , let ON1 = Int(N1) , let ON2 = Int(N2) {
            UpdateNote(not_id: OK, ders_adi: L , not1: ON1 , not2: ON2)
            }
        }
        Lesson.text = ""
        Note1.text = ""
        Note2.text = ""
    }
    
    func DeleteNote(not_id:Int){
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/delete_not.php")!)
        request.httpMethod = "POST"
        let postString = "not_id=\(not_id)"
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
    
    func UpdateNote(not_id:Int,ders_adi:String,not1:Int,not2:Int){
        var request = URLRequest(url: URL(string:"http://kasimadalan.pe.hu/notlar/update_not.php")!)
        request.httpMethod = "POST"
        let postString = "not_id=\(not_id)&ders_adi=\(ders_adi)&not1=\(not1)&not2=\(not2)"
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

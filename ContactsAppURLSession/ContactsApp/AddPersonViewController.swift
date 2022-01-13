//
//  AddPersonViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit

class AddPersonViewController: UIViewController {
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func AddClick(_ sender: Any) {
        if let N = Name.text , let P = Phone.text {
                AddPerson(kisi_ad: N, kisi_tel: P)
        }
        Name.text = ""
        Phone.text = ""
    }
    
    func AddPerson(kisi_ad:String,kisi_tel:String) {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php")!)
        request.httpMethod = "POST"
        let postString = "kisi_ad=\(kisi_ad) & kisi_tel=\(kisi_tel)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            if error != nil || data == nil {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                    print(json)
                }
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
  
}

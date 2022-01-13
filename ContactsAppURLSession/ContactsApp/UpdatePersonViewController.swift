//
//  UpdatePersonViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit

class UpdatePersonViewController: UIViewController {
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Phone: UITextField!
    var message:Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let N = message?.kisi_ad , let P = message?.kisi_tel {
            Name.text = N
            Phone.text = P
        }
        
    }
    

    @IBAction func UpdateClick(_ sender: Any) {
        
        if let N = Name.text , let P = Phone.text , let ID  = message?.kisi_id {
            if let OID = Int(ID) {
                UpdatePerson(kisi_id: OID, kisi_ad: N, kisi_tel: P)
            }
        }
        Name.text = ""
        Phone.text = ""
    }
    
    func UpdatePerson(kisi_id:Int,kisi_ad:String,kisi_tel:String) {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/update_kisiler.php")!)
        request.httpMethod = "POST"
        let postString = "kisi_id=\(kisi_id)&kisi_ad=\(kisi_ad)&kisi_tel=\(kisi_tel)"
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

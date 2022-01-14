//
//  AddPersonViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit
import Alamofire

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
        let parametre:Parameters = ["kisi_ad":"\(kisi_ad)","kisi_tel":"\(kisi_tel)"]
        AF.request("http://kasimadalan.pe.hu/kisiler/insert_kisiler.php", method: .post,parameters: parametre).response {
            (response) in
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
  
}

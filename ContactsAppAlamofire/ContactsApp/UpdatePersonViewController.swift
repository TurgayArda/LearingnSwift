//
//  UpdatePersonViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit
import Alamofire

class UpdatePersonViewController: UIViewController {
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Phone: UITextField!
    var message:Constact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let N = message?.kisi_ad , let P = message?.kisi_id {
            Name.text = N
            Phone.text = P
        }
        
    }
    

    @IBAction func UpdateClick(_ sender: Any) {
        if let N = Name.text , let P = Phone.text ,let ID = message?.kisi_id {
            UpdatePerson(kisi_id: ID, kisi_ad: N, kisi_tel: P)
        }
        Name.text = ""
        Phone.text = ""
    }
    
    func UpdatePerson(kisi_id:String,kisi_ad:String,kisi_tel:String) {
        let parametre:Parameters = ["kisi_id":"\(kisi_id)","kisi_ad":"\(kisi_ad)","kisi_tel":"\(kisi_tel)"]
        AF.request("http://kasimadalan.pe.hu/kisiler/update_kisiler.php", method: .post,parameters: parametre).response {
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

//
//  ViewController.swift
//  Coklu TableWView
//
//  Created by ArdaSisli on 24.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Ulkeler: UITableView!
    @IBOutlet weak var Sehirler: UITableView!
    
    var ulkeler  = [String]()
    var sehirler = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ulkeler = ["turkiye","almanya","afrika","rusya"]
        sehirler = ["urfa","istanbul","rize"]
      
        Ulkeler.dataSource = self
        Ulkeler.delegate = self
        Sehirler.dataSource = self
        Sehirler.dataSource = self
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var veri:Int?
        
        
        if tableView == Ulkeler {
            veri = ulkeler.count
        }
        if tableView == Sehirler {
            veri = sehirler.count
        }
        
            return veri!
        
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if tableView == Ulkeler {
            cell = tableView.dequeueReusableCell(withIdentifier: "ulke" , for: indexPath)
            cell?.textLabel?.text = ulkeler[indexPath.row]
        }
        if tableView == Sehirler {
            cell = tableView.dequeueReusableCell(withIdentifier: "sehir" , for: indexPath)
            cell?.textLabel?.text = sehirler[indexPath.row]
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == Ulkeler {
            print("secilen ulke : \(ulkeler[indexPath.row]) " )
        }
        
        if tableView == Sehirler {
            print("secilen sehir : \(sehirler[indexPath.row]) " )
        }
    }
    
    
}


//
//  ViewController.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var CaegoryTable: UITableView!
    
    var category = [Categories]()
    var ref:DatabaseReference!
    let TableCell = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        CaegoryTable.dataSource = self
        CaegoryTable.delegate = self
        
        ref = Database.database().reference()
        
        AllTheCategory()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
            let goingVC = segue.destination as! ViewController2
            goingVC.message = category[temp]
        }
    }
    
    func CategoryDict(temp:NSDictionary,key:String)->Categories {
        let key1 = key
        let name = temp["kategori_ad"] as? String ?? ""
        let cat = Categories(
            kategori_id: key1
            ,kategori_ad: name
        )
        return cat

    }
    
    func AllTheCategory() {
        ref.child("kategoriler").observe(.value, with: {
            (snapshot) in
            if let comingData = snapshot.value as? [String:AnyObject] {
                for ComingLine in comingData {
                    if let temp = ComingLine.value as? NSDictionary {
                        self.category.append(
                            self.CategoryDict(temp: temp
                                              ,key: ComingLine.key
                                             )
                        )
                        DispatchQueue.main.async {
                            self.CaegoryTable.reloadData()
                        }
                    }
                }
            }
        })
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coming = category[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell, for: indexPath) as! TableViewCell
        cell.CategoryName.text = coming.kategori_ad
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "1To2", sender: indexPath.row)
    }
}


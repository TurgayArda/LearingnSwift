//
//  ViewController.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var CaegoryTable: UITableView!
    
    var category = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CaegoryTable.dataSource = self
        CaegoryTable.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        AllTheCategory()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
            let goingVC = segue.destination as! ViewController2
            goingVC.message = category[temp]
        }
    }
    
    func AllTheCategory() {
        AF.request( "http://kasimadalan.pe.hu/filmler/tum_kategoriler.php" , method: .get).response {
            (response) in
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(CatCod.self, from: data)
                    if let coming = answer.kategoriler {
                        self.category = coming
                    }
                }catch{
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.CaegoryTable.reloadData()
                }
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.CategoryName.text = coming.kategori_ad
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "1To2", sender: indexPath.row)
    }
}


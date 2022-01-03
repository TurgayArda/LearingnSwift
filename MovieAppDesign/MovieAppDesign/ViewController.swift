//
//  ViewController.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var CaegoryTable: UITableView!
    
    var category = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        veritabaniKopyala()
        

        category = Categoryrdao().GettAllTheCategories()
      
        CaegoryTable.dataSource = self
        CaegoryTable.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
            let goingVC = segue.destination as! ViewController2
            goingVC.message = category[temp]
        }
        
    }
}

func veritabaniKopyala(){
    
    let bundleYolu = Bundle.main.path(forResource: "filmler", ofType: ".sqlite")
    
    let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    let fileManager = FileManager.default
    
    let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("filmler.sqlite")
    
    if fileManager.fileExists(atPath: kopyalanacakYer.path) {
        print("Veritabanı zaten var.Kopyalamaya gerek yok")
    }else{
        do {
            
            try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            
        }catch{
            print(error)
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


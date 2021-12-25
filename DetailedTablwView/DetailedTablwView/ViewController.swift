//
//  ViewController.swift
//  DetailedTablwView
//
//  Created by ArdaSisli on 26.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var TableView: UITableView!
    
    var Food = [Meals]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.dataSource = self
        TableView.delegate   = self
        
        let F1 = Meals(FoodName: "Ayran", FoodImageName: "ayran", FoodPrice: 3.5)
        let  F2 = Meals(FoodName: "Baklava", FoodImageName: "baklava", FoodPrice: 19.5)
        let  F3 = Meals(FoodName: "Fanta", FoodImageName: "fanta", FoodPrice: 12.0)
        let  F4 = Meals(FoodName: "Tavuk", FoodImageName: "tavuk", FoodPrice: 30.0)
        let  F5 = Meals(FoodName: "Kadayif", FoodImageName: "kadayif", FoodPrice: 25.5)
        let  F6 = Meals(FoodName: "Kofte", FoodImageName: "kofte", FoodPrice: 40.0)
        let  F7 = Meals(FoodName: "Pizza", FoodImageName: "pizza", FoodPrice: 63.0)
        let  F8 = Meals(FoodName: "Su", FoodImageName: "su", FoodPrice: 3.0)
        let  F9 = Meals(FoodName: "Sutlac", FoodImageName: "sutlac", FoodPrice: 13.5)
        
        Food.append(F1)
        Food.append(F2)
        Food.append(F3)
        Food.append(F4)
        Food.append(F5)
        Food.append(F6)
        Food.append(F7)
        Food.append(F8)
        Food.append(F9)
        
    }


}

extension ViewController:UITableViewDataSource,UITableViewDelegate,YesClick {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Coming = Food[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath) as! Cell
        cell.Proto       = self
        cell.index       = indexPath
    if let temp = Coming.FoodName {
        if let temp2 = Coming.FoodImageName {
               if let temp3 = Coming.FoodPrice {
                   cell.Food.text   = temp
                   cell.FoodPicture.image = UIImage(named: temp2)
                   cell.Price.text       = " \(temp3) "
           }
        }
     }
        return cell
  }
    
    func ButtonClick(indexPath: IndexPath) {
        let Coming =  Food[indexPath.row]
        if let temp = Coming.FoodName {
            if let temp2 = Coming.FoodImageName {
                   if let temp3 = Coming.FoodPrice {
        print("\(temp) selected and price: \(temp3)")
                }
            }
        }
    }
}


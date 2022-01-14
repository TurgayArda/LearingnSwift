//
//  ViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    var persons = [Constact]()
    var search = false
    var personS:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        SearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if search {
            SearchPerson(kisi_ad: personS)
        }else{
            AllThePerson()
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
        if segue.identifier == "ToDetail" {
            let goingVC = segue.destination as! DetailPersonViewController
            goingVC.message =  persons[temp]
            }
            if segue.identifier == "ToUpdate" {
                let goingVC = segue.destination as! UpdatePersonViewController
                goingVC.message =  persons[temp]
            }
        }
    }
    
    func AllThePerson() {
        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php", method: .get).response {
            (response) in
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(PersonAnswer.self, from: data)
                    if let coming = answer.kisiler {
                        self.persons = coming
                    }else{
                        self.persons = [Constact]()
                    }
                }catch{
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            }
        }
    }
    
    func SearchPerson(kisi_ad:String) {
        let parametre:Parameters = ["kisi_ad":"\(kisi_ad)"]
        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php", method: .post,parameters: parametre).response {
            (response) in
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(PersonAnswer.self, from: data)
                    if let coming = answer.kisiler {
                        self.persons = coming
                    }else{
                        self.persons = [Constact]()
                    }
                }catch{
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            }
        }
    }
    
    func DeletePerson(kisi_id:String) {
        let parametre:Parameters = ["kisi_id":"\(kisi_id)"]
        AF.request("http://kasimadalan.pe.hu/kisiler/delete_kisiler.php", method: .post,parameters: parametre).response {
            (response) in
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        self.AllThePerson()
                    }
                }catch{
                    print(error.localizedDescription)
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
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coming = persons[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        if let N = coming.kisi_ad {
            cell.Person.text = N
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let DeleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (UIContextualAction,view,Bool) in
            let t = self.persons[indexPath.row]
            if let t2 = t.kisi_id {
                    self.DeletePerson(kisi_id: t2)
            }
            
        }
        let UpdateAction = UIContextualAction(style: .normal, title: "Update") {
            (UIContextualAction,view,Bool) in
            self.performSegue(withIdentifier: "ToUpdate", sender: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [DeleteAction,UpdateAction])
    }
}

extension ViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        personS = searchText
        if searchText != "" {
            SearchPerson(kisi_ad: searchText)
            search = true
        }else{
            self.AllThePerson()
            search = false
        }
       
    }
    
    
}


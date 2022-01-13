//
//  ViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    var person = [Contacts]()
    var search = false
    var word:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.dataSource = self
        TableView.delegate = self
        SearchBar.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        if search {
            if let W = word {
                SearchPerson(kisi_ad: W)
            }
        }else{
            AllThePerson()
        }
        
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
            if segue.identifier == "ToDetail" {
                let goingVC = segue.destination as! DetailPersonViewController
                goingVC.message = person[temp]
            }
            if segue.identifier == "ToUpdate" {
                let goingVC = segue.destination as! UpdatePersonViewController
                goingVC.message = person[temp]
            }
        }
    }
    
    func DeletePerson(kisi_id:Int) {
        var request = URLRequest(url: URL(string:"http://kasimadalan.pe.hu/kisiler/delete_kisiler.php")!)
        request.httpMethod = "POST"
        let postString = "kisi_id=\(kisi_id)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            if error != nil || data == nil {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                    self.AllThePerson()
                }
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func AllThePerson() {
        let url = URL(string: "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php")!
        URLSession.shared.dataTask(with: url) {
            (data,response,error) in
            if error != nil || data == nil {
                return
            }
            do {
                let answer = try JSONDecoder().decode(Answer.self, from: data!)
                if let coming = answer.kisiler {
                    self.person = coming
                }else{
                    self.person = [Contacts]()
                }
                
            } catch  {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
        }.resume()
    }
    
    func SearchPerson(kisi_ad:String) {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php")!)
        request.httpMethod = "POST"
        let postString = "kisi_ad=\(kisi_ad)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            if error != nil || data == nil {
                return
            }
            do {
                let answer = try JSONDecoder().decode(Answer.self, from: data!)
                let coming = answer.kisiler!
                self.person = coming
            } catch  {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
        }.resume()
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coming = person[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.Person.text = "\(coming.kisi_ad!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let DeleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (UIContextualAction,view,Bool) in
            let t = self.person[indexPath.row]
            if let t2 = t.kisi_id {
                if let OT = Int(t2) {
                    self.DeletePerson(kisi_id: OT)
                }
            }
           
        }
        let UpdateAction = UIContextualAction(style: .normal, title: "Update") {
            (UIContextualAction,view,Bool) in
            self.performSegue(withIdentifier: "ToUpdate", sender: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [DeleteAction,UpdateAction])
    }
    
}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        word = searchText
        if searchText == "" {
            AllThePerson()
            search = false
        }else{
            SearchPerson(kisi_ad: searchText)
            search = true
        }
       
        
    }
}


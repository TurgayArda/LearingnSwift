//
//  ViewController.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    var person = [Persons]()
    var ref:DatabaseReference!
    var Se = false
    var W:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        SearchBar.delegate = self
        
        ref = Database.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Se {
            SearchPerson(S: W)
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
    
    func AllThePerson() {
        ref.child("kisiler").observe(.value, with: {
            (snapshot) in
            
            if let ComingData = snapshot.value as? [String:AnyObject] {
                self.person.removeAll()
                for comingLine in ComingData {
                    if let temp = comingLine.value as? NSDictionary {
                        let key = comingLine.key
                        let kisi_ad = temp["kisi_ad"] as? String ?? ""
                        let kisi_tel = temp["kisi_tel"] as? String ?? ""
                        
                        let p1 = Persons(kisi_id: key, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                        self.person.append(p1)
                    }
                }
            }else{
                self.person = [Persons]()
            }
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
        })
    }
    
    func SearchPerson(S:String) {
        ref.child("kisiler").observe(.value, with: {
            (snapshot) in
            
            if let ComingData = snapshot.value as? [String:AnyObject] {
                self.person.removeAll()
                for comingLine in ComingData {
                    if let temp = comingLine.value as? NSDictionary {
                        let key = comingLine.key
                        let ad = temp["kisi_ad"] as? String ?? ""
                        let kisi_tel = temp["kisi_tel"] as? String ?? ""
                        
                        if ad.contains(S) {
                            let a = Persons(kisi_id: key, kisi_ad: ad, kisi_tel: kisi_tel)
                            self.person.append(a)
                        }
                    }
                    DispatchQueue.main.async {
                        self.TableView.reloadData()
                    }
                }
            }else{
                self.person = [Persons]()
            }
        })
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
        cell.Person.text = coming.kisi_ad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let DeleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (UIContextualAction,view,Bool) in
            
            let z = self.person[indexPath.row]
            self.ref.child("kisiler").child(z.kisi_id!).removeValue()
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
        W = searchText
        if searchText == "" {
            AllThePerson()
            Se = false
        }else{
            SearchPerson(S: searchText)
            Se = true
        }
    }
}


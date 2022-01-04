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
    
  var persons = [Contacts]()
   var search = false
    var ara:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        veritabaniKopyala()
        
        TableView.delegate = self
        TableView.dataSource = self
        SearchBar.delegate = self
        
       
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if search {
            persons = Contactsdao().SearchPerson(kisi_ad: ara!)
        }else{
            persons = Contactsdao().GettAllThePerson()
        }
       
        TableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            if let temp = sender as? Int {
                let goingVC = segue.destination as! DetailPersonViewController
                goingVC.message = persons[temp]
            }
        }else{
            if let temp = sender as? Int {
                let goingVC = segue.destination as! UpdatePersonViewController
                goingVC.message = persons[temp]
            }
        }
    }

}

func veritabaniKopyala(){
    
    let bundleYolu = Bundle.main.path(forResource: "kisiler", ofType: ".sqlite")
    
    let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    let fileManager = FileManager.default
    
    let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("kisiler.sqlite")
    
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
        return persons.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coming = persons[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.Person.text = coming.kisi_ad
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let UpdateAction = UIContextualAction(style: .normal, title: "Update") {
            (UIContextualAction,view,Bool) in
                self.performSegue(withIdentifier: "ToUpdate", sender: indexPath.row)
        }
        let DeleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self]
            (UIContextualAction,view,Bool) in
            let coming = self.persons[indexPath.row]
            Contactsdao().DeletePerson(kisi_id: coming.kisi_id!)
            
            if self.search {
                self.persons = Contactsdao().SearchPerson(kisi_ad: self.ara!)
            }else{
                self.persons = Contactsdao().GettAllThePerson()
            }

            self.TableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [UpdateAction,DeleteAction])
    }
    
    
}
extension ViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ara = searchText
        if searchText == " " {
            search = false
        }else{
            search = true
        }
        persons = Contactsdao().SearchPerson(kisi_ad: searchText)
        TableView.reloadData()
        print(searchText)
    }
}


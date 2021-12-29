//
//  ViewController.swift
//  ContactsAppDesign
//
//  Created by ArdaSisli on 29.12.2021.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var SearchBarV: UISearchBar!
    
    @IBOutlet weak var TableViewV: UITableView!
    
    var PersonList = [Persons]()
    
    var searching = false
    
    var searchResult:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        TableViewV.delegate = self
        TableViewV.dataSource = self
        
        SearchBarV.delegate = self
        
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  let temp = sender as? Int {
        
        if segue.identifier == "1To3" {
            let toGoVC  = segue.destination as! ViewController3
            toGoVC.inComing = PersonList[temp]
        }
        
        if segue.identifier == "1To4" {
            let toGoVC  = segue.destination as! ViewController4
            toGoVC.inComing = PersonList[temp]
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if searching {
            if let temp = searchResult {
            search(person_name: temp)
            }
        }else{
            dataExtraction()
         
        }
        TableViewV.reloadData()
    }
    
    func dataExtraction() {
        do {
            PersonList =  try context.fetch(Persons.fetchRequest())
        } catch  {
            print(error)
        }
        
    }
    func search(person_name:String) {
        
        let fetchRequest:NSFetchRequest<Persons> = Persons.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "person_name CONTAINS %@", person_name)
        do {
            PersonList =  try context.fetch(fetchRequest)
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
        return PersonList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = PersonList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath) as! PersonsTableViewCell
        if let temp = person.person_name {
            if let temp2 = person.person_phone {
                cell.LabelCell.text = " \(temp) \(temp2)"
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let DeleteAction = UIContextualAction(style: .destructive , title: "Delete") {
            (UIContextualAction , view , Bool) in
            let person = self.PersonList[indexPath.row]
            self.context.delete(person)
            appDelegate.saveContext()
            
            if self.searching {
                if let temp = self.searchResult {
                    self.search(person_name: temp)
                }
            }else{
                self.dataExtraction()
             
            }
        
            
            self.TableViewV.reloadData()
            
            
        }
        let EditAction = UIContextualAction(style: .normal, title: "Edit") {
            (UIContextualAction , view , Bool) in
            self.performSegue(withIdentifier: "1To3", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration (actions: [DeleteAction,EditAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "1To4", sender: indexPath.row)
    }
}
extension ViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchResult = searchText
        
        if searchText == "" {
            dataExtraction()
            searching = false
        }else{
            if let temp = searchResult {
            search(person_name: temp)
            searching = true
            }
        }
        
        TableViewV.reloadData()
    }
}


//
//  ViewController.swift
//  NotesApp
//
//  Created by ArdaSisli on 10.01.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    var ref:DatabaseReference!
    
    var NotesList = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        TableView.delegate = self
        TableView.dataSource = self
        
        ref = Database.database().reference()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AllTheNotes()
    }
    
    func AllTheNotes() {
        ref.child("notlar").observe(.value, with: {
            snapshot in
            if let comingData = snapshot.value as? [String:AnyObject] {
                self.NotesList.removeAll()
                for ComingLine in comingData {
                    if let answer = ComingLine.value as? NSDictionary {
                        let key = ComingLine.key
                        let ders_adi = answer["ders_adi"] as? String ?? "None"
                        let not1 = answer["not1"] as? Int ?? 0
                        let not2 = answer["not2"] as? Int ?? 0
                        
                        let note = Notes(not_id: key, ders_adi: ders_adi, not1: not1, not2: not2)
                            self.NotesList.append(note)
                        }
                    }
            }else{
                self.NotesList = [Notes]()
            }
                DispatchQueue.main.async {
                    var total = 0
                    for i in self.NotesList {
                        if let t1 = i.not1 , let t2 = i.not2 {
                            total += (t1+t2)/2
                        }
                    }
                    if self.NotesList.count != 0 {
                        self.navigationItem.prompt = "Average: \(total / self.NotesList.count)"
                            total = 0
                        }else{
                        self.navigationItem.prompt = "Average: None"
                    }
                    self.TableView.reloadData()
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
            let GoingVC = segue.destination as! DetailViewController
            GoingVC.message = NotesList[temp]
        }
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coming = NotesList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.Lesson.text = coming.ders_adi
        cell.Note1.text = "\(coming.not1!)"
        cell.Note2.text = "\(coming.not2!)"
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToEdit", sender: indexPath.row)
    }
}


//
//  ViewController.swift
//  NotesApp
//
//  Created by ArdaSisli on 10.01.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    
    var NotesList = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        TableView.delegate = self
        TableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        AllTheNotes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ind = sender as? Int {
            let GoingVC = segue.destination as! DetailViewController
            GoingVC.message = NotesList[ind]
        }
    }
    
    func AllTheNotes() {
        AF.request("http://kasimadalan.pe.hu/notlar/tum_notlar.php" , method: .get).response {
            response in
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(Cod.self, from: data)
                    if let coming = answer.notlar {
                        self.NotesList = coming
                    }else{
                        self.NotesList = [Notes]()
                    }


                    DispatchQueue.main.async {
                        var total = 0
                        for i in self.NotesList {
                            if let t1 = i.not1 , let t2 = i.not2 {
                                if let OT1 = Int(t1) , let OT2 = Int(t2) {
                                    total += (OT1+OT2)/2
                                }
                            }
                        }
                                    if self.NotesList.count != 0 {
                                        self.navigationItem.prompt = "Average: \(total/self.NotesList.count)"
                                    }else{
                                        self.navigationItem.prompt = "Average: None"
                                    }
                        self.TableView.reloadData()
                        
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


//
//  ViewController.swift
//  NotesApp
//
//  Created by ArdaSisli on 2.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var NoteTableView: UITableView!
    
    var noteList = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       DataCopy()
        
        
        
        NoteTableView.delegate = self
        NoteTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        var total = 0
        
        noteList = Notedao().GetAllTheNotes()
        
        for n in noteList {
            total += (n.not1! + n.not2!)/2
        }
        if noteList.count != 0 {
            navigationItem.prompt =  "Averarge: \(total/noteList.count)"
        }else{
            navigationItem.prompt =  "Average: None"
        }
        NoteTableView.reloadData()
       
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
            let GoVC = segue.destination as! ViewController3
            GoVC.message = noteList[temp]
        }
    }
    
    


}

func DataCopy() {
let bundlePath = Bundle.main.path(forResource: "notlar", ofType: ".sqlite")
let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
let filemenager = FileManager.default
let copyPath = URL(fileURLWithPath: targetPath).appendingPathComponent("notlar.sqlite")
if filemenager.fileExists(atPath: copyPath.path) {
    print("veri zaten var")
    
}else{
    
    do {
        
    try filemenager.copyItem(atPath: bundlePath! , toPath: copyPath.path)
        
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
        return noteList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coming = noteList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        if let n1 = coming.not1 {
            if let n2 = coming.not2 {
                if let l1 = coming.ders_adi {
                cell.Lesson.text = l1
                cell.Note1.text = String(n1)
                cell.Note2.text = String(n2)
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "1To3", sender: indexPath.row)
    }
}


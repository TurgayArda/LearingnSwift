//
//  ViewController2.swift
//  UserDefaultLoginApp
//
//  Created by ArdaSisli on 27.12.2021.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var UserLabel: UILabel!
    let d = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let un = d.string(forKey: "username")
        UserLabel.text = un
        
        

        navigationItem.hidesBackButton = true
    }
    
    @IBAction func ExitBar(_ sender: Any) {
        d.removeObject(forKey: "Password")
        d.removeObject(forKey: "username")
        exit(-1)
    }
    
}

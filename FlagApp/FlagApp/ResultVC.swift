//
//  ResultVC.swift
//  FlagApp
//
//  Created by ArdaSisli on 31.12.2021.
//

import UIKit

class ResultVC: UIViewController {
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    @IBOutlet weak var RatioLabel: UILabel!
    
    var mesaj:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        if let d = mesaj {
            ResultLabel.text = "\(d) True  \(5-d) False"
            RatioLabel.text = " % \(d*100 / 5) Success"
        }
        
    }
    

    @IBAction func AgainClick(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    

}

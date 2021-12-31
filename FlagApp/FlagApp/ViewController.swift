//
//  ViewController.swift
//  FlagApp
//
//  Created by ArdaSisli on 31.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var LabelV1: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      DataCopy()
    }

    func DataCopy() {
    let bundlePath = Bundle.main.path(forResource: "FlagApp", ofType: ".sqlite")
    let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let filemenager = FileManager.default
    let copyPath = URL(fileURLWithPath: targetPath).appendingPathComponent("FlagApp.sqlite")
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

    
}


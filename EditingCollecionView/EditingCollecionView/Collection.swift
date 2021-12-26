//
//  Collection.swift
//  EditingCollecionView
//
//  Created by ArdaSisli on 26.12.2021.
//

import UIKit

protocol CollectionCell {
    func ClickCell(indexPath:IndexPath)
}

class Collection: UICollectionViewCell {
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Price: UILabel!
    
    var proto:CollectionCell?
    var index:IndexPath?
    
    
    @IBAction func Click(_ sender: Any) {
        if let temp = index {
        proto?.ClickCell(indexPath: temp)
        }
    }
    
}

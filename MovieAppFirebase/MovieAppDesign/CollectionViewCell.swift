//
//  CollectionViewCell.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import UIKit

protocol ProtokolCell {
    func AddButton(indexPath:IndexPath)
}

class CollectionViewCell: UICollectionViewCell {
    
   
    @IBOutlet weak var MovieImage: UIImageView!
    
    @IBOutlet weak var PriceLabel: UILabel!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    var proto:ProtokolCell?
    var index:IndexPath?
    
    @IBAction func AddClick(_ sender: Any) {
        if let temp = index {
        proto?.AddButton(indexPath: temp)
            
        }
    }
}

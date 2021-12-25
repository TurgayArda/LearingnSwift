//
//  Cell.swift
//  DetailedTablwView
//
//  Created by ArdaSisli on 26.12.2021.
//

import UIKit

protocol YesClick {
    
    func ButtonClick(indexPath:IndexPath)
}

class Cell: UITableViewCell {
   
    @IBOutlet weak var FoodPicture: UIImageView!
    
    @IBOutlet weak var Food: UILabel!
    
    @IBOutlet weak var Price: UILabel!
    
    var index:IndexPath?
    var Proto:YesClick?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

    @IBAction func Click(_ sender: Any) {
        if let temp = index {
        Proto?.ButtonClick(indexPath:temp )
        }
    }
}

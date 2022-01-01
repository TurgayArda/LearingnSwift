//
//  TableViewCell.swift
//  DictionaryDesign
//
//  Created by ArdaSisli on 1.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var English: UILabel!
    @IBOutlet weak var Turkce: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}

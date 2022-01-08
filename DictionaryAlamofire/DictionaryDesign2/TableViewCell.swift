//
//  TableViewCell.swift
//  DictionaryDesign2
//
//  Created by ArdaSisli on 7.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var ELabel: UILabel!
    @IBOutlet weak var TLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}

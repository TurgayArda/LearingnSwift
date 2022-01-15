//
//  TableViewCell.swift
//  ContactsApp
//
//  Created by ArdaSisli on 4.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var Person: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}

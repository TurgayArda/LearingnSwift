//
//  TableViewCell.swift
//  NotesApp
//
//  Created by ArdaSisli on 10.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Lesson: UILabel!
    @IBOutlet weak var Note1: UILabel!
    @IBOutlet weak var Note2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

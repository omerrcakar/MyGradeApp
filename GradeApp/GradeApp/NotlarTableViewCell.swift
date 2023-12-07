//
//  NotlarTableViewCell.swift
//  GradeApp
//
//  Created by ÖMER  on 6.12.2023.
//

import UIKit

class NotlarTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var dersAdi: UILabel!
    @IBOutlet weak var vizeNotu: UILabel!
    @IBOutlet weak var finalNotu: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

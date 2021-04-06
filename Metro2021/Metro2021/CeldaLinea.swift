//
//  CeldaLinea.swift
//  Metro2021
//
//  Created by Sara Gil González on 21/2/21.
//

import UIKit

class CeldaLinea: UITableViewCell {

    @IBOutlet weak var ivNLinea: UIImageView!
    @IBOutlet weak var lblLinea: UILabel!
    @IBOutlet weak var lblIniFin: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

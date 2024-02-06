//
//  MealFilterTableViewCell.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 06/02/24.
//

import UIKit

class MealFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var checkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func tapCheckButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}

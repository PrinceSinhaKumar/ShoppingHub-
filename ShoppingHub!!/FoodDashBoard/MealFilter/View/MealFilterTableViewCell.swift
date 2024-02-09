//
//  MealFilterTableViewCell.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 06/02/24.
//

import UIKit

class MealFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var selectCategory: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
  
    var viewModel: CategoryModel? {
        didSet{
            configure(model: viewModel!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func categorySelection(status: Bool) {
       selectCategory.isHighlighted = status
    }
    
    //MARK: Methods
    func configure(model: CategoryModel) {
        categoryLabel.text = model.categoryName
        categorySelection(status: model.selectedStatus)
    }
}


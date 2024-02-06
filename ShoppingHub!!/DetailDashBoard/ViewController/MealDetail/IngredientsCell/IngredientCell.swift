//
//  IngredientCell.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 04/02/24.
//

import UIKit
import Kingfisher

class IngredientCell: UICollectionViewCell {
    
    @IBOutlet weak var ingName: UILabel!
    
    var viewModel: IngredientCellViewModel?{
        didSet{
            configure()
        }
    }
    
    fileprivate func configure(){
        ingName.text = "\(viewModel?.ingName ?? "")"
    }
}

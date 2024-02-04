//
//  MealCollectionViewCell.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 04/02/24.
//

import UIKit
import Kingfisher

class MealCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ingName: UILabel!
    @IBOutlet weak var ingThumb: UIImageView!
    
    var viewModel: MealCollectionCellViewModel?{
        didSet{
            configure()
        }
    }
    
    fileprivate func configure(){
        ingName.text = viewModel?.ingName
        if let imageURL = viewModel?.getIngURL() { ingThumb.kf.setImage(with: imageURL) }
    }
}

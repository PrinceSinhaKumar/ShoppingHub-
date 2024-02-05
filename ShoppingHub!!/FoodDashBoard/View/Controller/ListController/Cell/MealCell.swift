//
//  MealCell.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 31/01/24.
//

import UIKit
import Kingfisher

class MealCell: UITableViewCell {
    
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealType: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var lblcookingTime: UILabel!
    @IBOutlet weak var mealIngredients: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var viewModel: MealCellViewModel?{
        didSet{
            configureCell()
        }
    }
    var coordinator: NavigationCoordinator!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mealName.font = AppFont.font(with: 15, family: OpenSans.bold)
        mealType.font = AppFont.font(with: 12, family: OpenSans.regular)
        lblcookingTime.font = AppFont.font(with: 12, family: OpenSans.light)
        mealIngredients.font = AppFont.font(with: 12, family: OpenSans.light)
    }
    
    //MARK: Methods
    func configure(viewModel: MealCellViewModel,
                   coordinator: NavigationCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    @IBAction func tapAddReceipe(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        viewModel?.updateFavourite(sender.isSelected)
        addFavourite()
    }
    @IBAction func tapShareMeal(_ sender: Any) {
        if let url = viewModel?.getYoutubeURL() {
            coordinator.openRecipe(url: url)
        }
    }
    
    private func configureCell() {
        if let imageURL = viewModel?.mealImageURL { mealImage.kf.setImage(with: imageURL) }
        mealName.text = viewModel?.strMeal
        mealType.text = viewModel?.strCategory
        mealIngredients.text = viewModel?.ingridients
        if let isFavourite = viewModel?.isFavourite{
            favouriteButton.isSelected = isFavourite
        }
    }
    
    func addFavourite(){
        if let vm = viewModel {
            MealDataManager.shared.addFavouriteMeal(mealId: vm.mealId, isFavourite: vm.isFavourite)
        }
    }
}

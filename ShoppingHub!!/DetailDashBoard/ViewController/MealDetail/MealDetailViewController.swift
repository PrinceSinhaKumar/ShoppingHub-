//
//  MealDetailViewController.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 04/02/24.
//

import UIKit

class MealDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mealCategory: UILabel!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealInstructions: UILabel!
    @IBOutlet weak var mealIngredrients: UILabel!
    @IBOutlet weak var favtButton, shareButton: UIButton!

    fileprivate var viewModel: MealDetailViewModel?
    fileprivate var ingredientDataSource: IngredientDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configure(viewModel: MealDetailViewModel,
                   ingredientDataSource: IngredientDataSource) {
        self.viewModel = viewModel
        self.ingredientDataSource = ingredientDataSource
        self.ingredientDataSource?.configure(viewModel: viewModel)
    }
    
    fileprivate func configureCollection() {
        collectionView.dataSource = ingredientDataSource
        collectionView.delegate = self
    }
  
    fileprivate func configureUI(){
        mealName.text = viewModel?.getMeal().strMeal
        mealInstructions.attributedText = viewModel?.totalSteps()
        mealCategory.text = " \(viewModel?.getMeal().strArea ?? "")"
        mealIngredrients.text = "Ingredients (\(viewModel?.getMeal().indredients?.count ?? 0))"
        favtButton.isSelected = viewModel?.getMeal().isFavourite ?? false
        configureCollection()
    }
    
    @IBAction func addToFavtButton(sender: UIButton) {
        let status = !sender.isSelected
        sender.isSelected = status
        let id = viewModel?.getMeal().idMeal ?? ""
        MealDataManager.shared.addFavouriteMeal(mealId: id, isFavourite: status)
    }
}

extension MealDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 94, height: 80)
    }
}

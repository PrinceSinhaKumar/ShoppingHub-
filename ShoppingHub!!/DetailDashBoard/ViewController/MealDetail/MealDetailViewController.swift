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
    
    fileprivate var collectionViewDataSource: MealCollectionViewDataSource!

    fileprivate var viewModel: MealDetailViewModel?{
        didSet{
            configureUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
    }
    
    func configure(viewModel: MealDetailViewModel) {
        self.viewModel = viewModel
    }
    
    fileprivate func configureCollection() {
        collectionViewDataSource = MealCollectionViewDataSource(viewModel: self.viewModel)
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self
    }
  
    fileprivate func configureUI(){
        mealName.text = viewModel?.getMeal().strMeal
        mealInstructions.text = viewModel?.getMeal().strInstructions
    }
}

extension MealDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 94, height: 128)
    }
}

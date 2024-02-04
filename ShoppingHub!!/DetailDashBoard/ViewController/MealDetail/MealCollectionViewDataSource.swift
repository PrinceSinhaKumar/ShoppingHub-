//
//  MealCollectionViewDataSource.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 04/02/24.
//

import Foundation
import UIKit

class MealCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    fileprivate var viewModel: MealDetailViewModel!
    
    init(viewModel: MealDetailViewModel?) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealCollectionViewCell", for: indexPath) as! MealCollectionViewCell
        return cell
    }
 
}

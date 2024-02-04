//
//  MealDetailViewController.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 04/02/24.
//

import UIKit

class MealDetailViewController: UIViewController {

    fileprivate var viewModel: MealDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configure(viewModel: MealDetailViewModel) {
        self.viewModel = viewModel
    }
    
}

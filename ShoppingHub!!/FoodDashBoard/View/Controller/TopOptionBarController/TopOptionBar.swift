//
//  TopOptionBar.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 31/01/24.
//

import Pageboy
import Tabman
import UIKit

class TopOptionBar: TMBar.ButtonBar {
    //MARK: - Properties
    let viewModel: FoodTopOptionbarViewModelDelegate
    let controller: [UIViewController]
    
    init(viewModel: FoodTopOptionbarViewModelDelegate, controller: [UIViewController]) {
        self.viewModel = viewModel
        self.controller = controller
        super.init()
        self.layout.transitionStyle = .progressive // Customize
        // Customize bar properties including layout and other styling.
        self.layout.contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 4.0, right: 16.0)
        self.layout.interButtonSpacing = 10
        self.fadesContentEdges = true
        self.spacing = 5
        
        // Set tint colors for the bar buttons and indicator.
        self.buttons.customize {
            $0.tintColor = .black.withAlphaComponent(0.5)
            $0.selectedTintColor = .black
            $0.adjustsFontForContentSizeCategory = true
            $0.backgroundColor = AppColor.AppWhiteSecond.color
            $0.layer.cornerRadius = 8
        }
        self.indicator.backgroundColor = .clear
        self.backgroundView.style = .clear
        
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - PageboyViewControllerDataSource, TMBarDataSource 
extension TopOptionBar: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewModel.numberTabs()
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return controller[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: viewModel.getTitle(index: index))
    }
}

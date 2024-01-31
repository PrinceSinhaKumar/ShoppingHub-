//
//  FoodOptionTopBarController.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import UIKit
import Pageboy
import Tabman

class FoodOptionTopBarController: TabmanViewController {
    
    //MARK: - Properties
    var viewModel = FoodTopOptionbarViewModel()
    var controller: [UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.menuList?.forEach({ title in
            controller.append(ListController())
        })
        
        self.dataSource = self
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        // Customize bar properties including layout and other styling.
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 4.0, right: 16.0)
        bar.layout.interButtonSpacing = 24.0
        bar.indicator.weight = .light
        bar.indicator.cornerStyle = .eliptical
        bar.fadesContentEdges = true
        bar.spacing = 16.0
        
        // Set tint colors for the bar buttons and indicator.
        bar.buttons.customize {
            $0.tintColor = .gray.withAlphaComponent(0.5)
            $0.selectedTintColor = .gray
            $0.adjustsFontForContentSizeCategory = true
        }
        bar.indicator.backgroundColor = AppColor.AppLightBlue.color
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
}
extension FoodOptionTopBarController: PageboyViewControllerDataSource, TMBarDataSource {

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
        let title = "Page \(index)"
        return TMBarItem(title: viewModel.getTitle(index: index))
    }
}

class ListController: UIViewController {
    
}

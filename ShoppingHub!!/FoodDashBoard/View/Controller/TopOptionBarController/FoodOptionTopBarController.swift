//
//  FoodOptionTopBarController.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import UIKit
import XLPagerTabStrip

class FoodOptionTopBarController: ButtonBarPagerTabStripViewController {

    //MARK: - Properties
    lazy private var cachedCellWidths: [CGFloat]? = { [unowned self] in
        return self.calculateWidths()
    }()
    var changeCurrentIndexNew: ((FoodTopBarCollectionViewCell?, FoodTopBarCollectionViewCell?, Bool) -> Void)?
    var changeCurrentIndexProgressiveNew: ((FoodTopBarCollectionViewCell?, FoodTopBarCollectionViewCell?, CGFloat, Bool, Bool) -> Void)?
    var navController: UINavigationController?
    var viewModel = FoodTopOptionbarViewModel()
    
    override func viewDidLoad() {

        super.viewDidLoad()

        buttonBarView.register(FoodTopBarCollectionViewCell.self, forCellWithReuseIdentifier: "FoodTopBarCollectionViewCell")
        configureTabViewSettings()


    }
//    override func reloadPagerTabStripView() {
//        super.reloadPagerTabStripView()
//        guard !viewControllers.isEmpty else { fatalError("")}
//        viewControllers.forEach({if !($0 is IndicatorInfoProvider) {
//            fatalError("rr")
//        }})
//        cachedCellWidths = calculateWidths()
//        buttonBarView.reloadData()
//        buttonBarView.moveTo(index: currentIndex, animated: false, swipeDirection: .none, pagerScroll: .yes)
//    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { [weak self] _ in
            self?.containerView.setContentOffset(CGPoint(x: (self?.containerView.bounds.width ?? 0) * CGFloat(self?.currentIndex ?? 0), y: 0), animated: false)
        } completion: { [weak self]_ in
            self?.buttonBarView.layoutIfNeeded()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item != currentIndex else { return }
        buttonBarView.moveTo(index: indexPath.item, animated: true, swipeDirection: .none, pagerScroll: .yes)
        //shouldUpdateButtonBarView = false
        let oldIndexPath = IndexPath(item: currentIndex, section: 0)
        let newIndexPath = IndexPath(item: indexPath.item, section: 0)
        let cells = cellForItemNew(at: [oldIndexPath, newIndexPath], reloadIfNotVisible: false)
        if pagerBehaviour.isProgressiveIndicator {
            if let changeCurrentIndexProgressiveNew = changeCurrentIndexProgressiveNew {
                changeCurrentIndexProgressiveNew(cells.first!, cells.last!, 1, true, true)
            }}
        else {
            if let changeCurrentIndexNew = changeCurrentIndexNew {
                changeCurrentIndexNew(cells.first!, cells.last!, true)
            }}
        moveToViewController(at: indexPath.item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodTopBarCollectionViewCell", for: indexPath) as? FoodTopBarCollectionViewCell else {
            return UICollectionViewCell()
        }
        let childController = viewControllers[indexPath.item] as! IndicatorInfoProvider
        
        cell.lblTitle.text = childController.indicatorInfo(for: self).title
        cell.backgroundColor = AppColor.AppLightBlue.color//
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        guard let cellWidthValue = cachedCellWidths?[indexPath.row] else {
            fatalError("")
        }
        return CGSize(width: cellWidthValue, height: collectionView.frame.size.height)
    }
    
    func cellForItemNew(at indexPath: [IndexPath], reloadIfNotVisible reload: Bool = true) -> [FoodTopBarCollectionViewCell?] {
        let cells = indexPath.map({ buttonBarView.cellForItem(at: $0) as? FoodTopBarCollectionViewCell })
        if reload {
            let indexPathsToReload = cells.enumerated().compactMap { (arg) -> IndexPath? in
                let (index, cell) = arg
                return cell == nil ? indexPath[index] : nil
            }.compactMap { (indexPath: IndexPath) -> IndexPath? in
                if indexPath.item == viewModel.menuList?.count {
                    return nil
                }
                return (indexPath.item >= 0 && indexPath.item < buttonBarView.numberOfItems(inSection: indexPath.section)) ? indexPath : nil
            }
            
            if !indexPathsToReload.isEmpty {
                buttonBarView.reloadItems(at: indexPathsToReload)
            }
        }
        return cells
    }
    
    private func configureTabViewSettings(){
        settings.style.buttonBarBackgroundColor = AppColor.AppWhite255.color
        settings.style.buttonBarItemBackgroundColor = AppColor.AppWhite255.color
        settings.style.buttonBarHeight = 24
        settings.style.buttonBarLeftContentInset = 16
        settings.style.buttonBarRightContentInset = 16
        settings.style.buttonBarItemsShouldFillAvailableWidth = false
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarItemFont = AppFont.font(with: 15, family: OpenSans.regular)
        settings.style.buttonBarItemTitleColor = AppColor.AppLightBlue.color
        settings.style.selectedBarBackgroundColor = AppColor.AppLightBlue.color!
        
        changeCurrentIndexProgressiveNew = {[weak self] (oldCell: FoodTopBarCollectionViewCell?,
                                                         newCell: FoodTopBarCollectionViewCell?,
                                                         progress: CGFloat,
                                                         changeCurrentIndex:Bool,
                                                         animate: Bool) -> Void in
            guard let self = self else { return }
            oldCell?.lblTitle.textColor = AppColor.AppBlackTitle.color
            oldCell?.lblTitle.font = AppFont.font(with: 15, family: OpenSans.regular)
            newCell?.lblTitle.textColor = AppColor.AppBlackTitle.color
            newCell?.lblTitle.font = AppFont.font(with: 15, family: OpenSans.regular)
            
        }
    }

    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var page = Array<UIViewController>()
        viewModel.menuList?.forEach({ topTitle in
            page.append(ChildViewController(indicatorTitle: topTitle))
        })
        return page
    }


}
//MARK: - XLPagerTabStrip extension
extension FoodOptionTopBarController {
    
    fileprivate func calculateWidths() -> [CGFloat] {
        let flowLayout = buttonBarView.collectionViewLayout as! UICollectionViewFlowLayout
        let numberCells = viewControllers.count
        
        var minimumCellWidths: [CGFloat] = []
        var collectionViewContentWidth: CGFloat = 0
        
        viewControllers.forEach { vc in
            let childController = vc as! IndicatorInfoProvider
            let indicatorInfo = childController.indicatorInfo(for: self)
            
            switch buttonBarItemSpec {
            case .cellClass(let widthCallback):
                let width = widthCallback(indicatorInfo)
                minimumCellWidths.append(width)
                collectionViewContentWidth += width
            case .nibFile(nibName: _, bundle: _, let widthCallback):
                var width: CGFloat!
                if indicatorInfo.title != nil {
                    let label = UILabel()
                    let boldFont = AppFont.font(with: 12, family: OpenSans.medium)
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.font = boldFont
                    label.text = indicatorInfo.title
                    let labelSize = label.intrinsicContentSize
                    width = labelSize.width + (settings.style.buttonBarItemLeftRightMargin) * 2
                } else {
                    width = widthCallback(indicatorInfo)
                }
                minimumCellWidths.append(width)
                collectionViewContentWidth += width
            default:
                break
            }
        }
        
        let cellSpacingTotal = CGFloat(numberCells - 1) * flowLayout.minimumLineSpacing
        collectionViewContentWidth += cellSpacingTotal
        
        let collectionViewAvailableVisibleWidth = buttonBarView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right
        if !settings.style.buttonBarItemsShouldFillAvailableWidth || collectionViewAvailableVisibleWidth < collectionViewContentWidth {
            return minimumCellWidths
        } else {
            let strCellWidthIfAllEqual = (collectionViewAvailableVisibleWidth - cellSpacingTotal) / CGFloat(numberCells)
            let generalMinimumCellWidth = calculateStretchedCellWidths(minimumCellWidths, suggestedStretchedCellWidth: strCellWidthIfAllEqual, previousNumberOfLargeCells: 0)
            var strCellWidths: [CGFloat] = []
            minimumCellWidths.forEach { width in
                let cellWidth = (width > generalMinimumCellWidth) ? width : generalMinimumCellWidth
                strCellWidths.append(cellWidth)
            }
            return strCellWidths
        }
    }
}

class ChildViewController: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.title)
    }
    var indicatorInfo: IndicatorInfo
    
    init(indicatorTitle: String) {
        self.indicatorInfo = IndicatorInfo(title: indicatorTitle)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Other methods and properties of your child view controller...
}

//
//  MealCollectionCellViewModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 04/02/24.
//

import Foundation

class MealCollectionCellViewModel {
    
    var thumbImgURL: String
    var ingName: String
    
    init(thumbImgURL: String, ingName: String) {
        self.thumbImgURL = thumbImgURL
        self.ingName = ingName
    }
    
    func getIngURL() -> URL{
        return URL(string: thumbImgURL)!
    }
}

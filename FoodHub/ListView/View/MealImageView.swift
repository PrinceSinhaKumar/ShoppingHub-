//
//  MealImageView.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 05/05/24.
//

import SwiftUI

struct MealImageView: View {
    @State var image: UIImage?
    var imageURL:String
    var body: some View {
        
        AsyncImage(url: URL(string: imageURL)!) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .clipShape(Circle())
        } placeholder: {
            VStack {
                Spacer()
                ProgressView()
                    .frame(width: 100)
                    .progressViewStyle(.circular).tint(AppColor.AppOrange.swiftUIColor)
                Spacer()
            }
        }

//        if let image = self.image {
//            Image(uiImage: image)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 120)
//                .clipShape(Circle())
//        } else {
//            VStack {
//                Spacer()
//                ProgressView()
//                    .frame(width: 100)
//                    .progressViewStyle(.circular).tint(AppColor.AppOrange.swiftUIColor)
//                    .onAppear {
//                        loadImage(from: imageURL)
//                    }
//                Spacer()
//            }
//        }
        
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImage = ImageCache.shared.getImage(for: urlString) {
            image = cachedImage
        } else {
            ImageDownloader.shared.downloadImage(imageURL: url) { (image) in
                guard let image = image else { return }
                ImageCache.shared.setImage(image, for: urlString)
                self.image = image
            }
        }
    }
}

#Preview {
    MealImageView(imageURL: "")
}

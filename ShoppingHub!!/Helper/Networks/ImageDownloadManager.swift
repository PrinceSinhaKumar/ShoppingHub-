//
//  ImageDownloadManager.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 04/05/24.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getImage(for urlString: String) -> UIImage? {
        return cache.object(forKey: urlString as NSString)
    }

    func setImage(_ image: UIImage, for urlString: String) {
        cache.setObject(image, forKey: urlString as NSString)
    }
}

class ImageDownloader {
    
    static let shared = ImageDownloader()
    let operationQueue: OperationQueue
    
   private init() {
        self.operationQueue = OperationQueue()
        self.operationQueue.maxConcurrentOperationCount = 1
    }
    
    func downloadImage(imageURL: URL,
                        completion: @escaping (UIImage?) -> Void) {
        let imageDownloadOperation = ImageDownloaderOperation(imageURL: imageURL) { item in
            if let image = item {
                completion(image)
            } else {
                completion(nil)
            }
        }
        operationQueue.addOperation(imageDownloadOperation)
    }
}

class ImageDownloaderOperation: Operation {
    let imageURL: URL
    let completion: (UIImage?) -> Void

    init(imageURL: URL, completion: @escaping (UIImage?) -> Void) {
        self.imageURL = imageURL
        self.completion = completion
    }
    
    override func main() {
        guard !isCancelled else {
           return
        }
        if let imageData = try? Data(contentsOf: imageURL) {
            let image = UIImage(data: imageData)
            completion(image)
        } else {
            completion(nil)
        }
    }
}

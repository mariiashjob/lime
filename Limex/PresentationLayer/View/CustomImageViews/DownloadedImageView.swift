//
//  DownloadedImageView.swift
//  Limex
//
//  Created by m.shirokova on 19.01.2023.
//

import Foundation
import UIKit

final class DownloadedImageView: UIImageView {
    var imageUrlString: String?
    let apiBuilder = ApiBuilder()
    func downloadImage(urlString: String) {
        self.imageUrlString = urlString
        guard let url = URL(string: urlString) else {
            return
        }
        image = nil
        let imageCash = NSCache<NSString, UIImage>()
        if let imageFromCash = imageCash.object(forKey: urlString as NSString) {
            self.image = imageFromCash
            return
        }
        self.apiBuilder.downloadImage(url) { result in
            do {
                let imageToCash = try UIImage(data: result.get())
                if self.imageUrlString == urlString {
                    DispatchQueue.main.async {
                        self.image = imageToCash
                    }
                }
                guard let imageToCash = imageToCash else {
                    return
                }
                imageCash.setObject(imageToCash, forKey: urlString as NSString)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

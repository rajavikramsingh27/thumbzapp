//
//  commonFunctionsAndExtensions.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 01/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill) {
//        SVProgressHUD.show()
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
//        SVProgressHUD.dismiss()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
        
    }
}

//
//  UIImageView+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

import UIKit

extension UIImageView {
    
    /// Загрузка изображения по `URL`.
    ///
    /// Изображение будет получено либо из кэша (при наличии), либо загрузится из сети, с последующим сохранением в кэш.
    /// - Parameter url: `URL` изображения.
    func fetchImage(byURL url: URL) {
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if let imageData = cache.cachedResponse(for: request)?.data {
            image = UIImage(data: imageData)
        } else {
            URLSession.shared.dataTask(with: request) { [weak self] data, response, _ in
                DispatchQueue.main.async {
                    guard let data = data, let response = response else { return }
                    
                    let cacheRepsonse = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cacheRepsonse, for: request)
                    self?.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

//
//  UIImageView+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

import Kingfisher

extension UIImageView {
    
    /// Загрузка изображения по `URL`.
    /// - Parameter url: `URL` изображения.
    func fetchImage(byURL url: URL) {
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}

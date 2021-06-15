//
//  UIImageView+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

import Kingfisher

extension UIImageView {
    
    /// Установка изображения, полученного  по переданному `URL`.
    /// - Parameter url: `URL` изображения.
    func setImage(byURL url: URL?) {
        guard let url = url else { return }
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}

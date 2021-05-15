//
//  UIView+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 15.05.2021.
//

import UIKit

extension UIView {
    
    func tapAnimation(
        duration: TimeInterval = 0.15,
        delay: TimeInterval = 0,
        scale: CGFloat = 0.98,
        completion: @escaping VoidBlock
    ) {
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseOut, .autoreverse]) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        } completion: { isDone in
            if isDone {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
                completion()
            }
        }
    }
}

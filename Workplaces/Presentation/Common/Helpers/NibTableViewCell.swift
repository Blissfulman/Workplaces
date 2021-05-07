//
//  UITableViewCell+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.05.2021.
//

import UIKit

protocol NibTableViewCell {
    static var identifier: String { get }
    static func nib() -> UINib
}

extension UITableViewCell: NibTableViewCell {
    
    static var identifier: String {
        String(describing: Self.self)
    }
        
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
}

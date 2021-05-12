//
//  TableViewOffsetConfigurable.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 12.05.2021.
//

import UIKit

/// Используется для настройки и отслеживания смещения контента таблиц в дочерних контроллерах.
protocol TableViewOffsetConfigurable: UIViewController {
    
    /// Значение параметра `contentOffset` таблицы.
    var contentOffset: CGPoint { get }
    
    /// Установка параметра `contentInset` для таблицы.
    /// - Parameter contentInset: Значение `contentInset`.
    func setContentInset(contentInset: UIEdgeInsets)
    
    /// Установка смещения контента от верхнего края для таблицы.
    /// - Parameter topOffset: Значение смещения.
    func setTopOffset(offset: CGFloat)
}

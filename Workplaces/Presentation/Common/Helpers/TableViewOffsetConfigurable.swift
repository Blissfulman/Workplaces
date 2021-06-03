//
//  TableViewOffsetConfigurable.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 12.05.2021.
//

import UIKit

/// Используется для настройки и отслеживания положения контента таблиц в дочерних контроллерах.
protocol TableViewOffsetConfigurable: UIViewController {
    
    /// Значение положения верхнего края контента таблицы по вертикали.
    var topYContentPosition: CGFloat { get }
    
    /// Установка изначального вертикального смещения контента таблицы.
    /// - Parameter offset: Значение смещения.
    func setInitialVerticalOffset(_ offset: CGFloat)
    
    /// Сброс смещения контента таблицы к изначальному значению.
    func resetToInitialOffset()
}

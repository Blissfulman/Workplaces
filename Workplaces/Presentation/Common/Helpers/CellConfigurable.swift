//
//  CellConfigurable.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 12.05.2021.
//

import UIKit

/// Обязывает подписанный класс реализовывать метод конфигурации ячейки `configure(object: Object)`, где `Object` - ассоциированный тип передаваемого в ячейку объекта.
protocol CellConfigurable: UITableViewCell {
    
    associatedtype Object: Any
    
    /// Метод конфигурации содержимого ячейки.
    /// - Parameter object: Объект данных для конфигурации.
    func configure(object: Object)
}

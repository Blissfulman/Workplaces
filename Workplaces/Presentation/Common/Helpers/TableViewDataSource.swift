//
//  TableViewDataSource.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 11.05.2021.
//

import UIKit

// MARK: - Protocols

protocol TableViewDataSourceDelegate: AnyObject {
    func needReloadData()
}

final class TableViewDataSource<Object: Comparable, Cell: CellConfigurable>: NSObject, UITableViewDataSource
where Cell.Object == Object {
    
    // MARK: - Public properties
    
    weak var delegate: TableViewDataSourceDelegate?
    
    // MARK: - Private properties
    
    private var objects: [Object]
    
    // MARK: - Initializers
    
    init(objects: [Object] = []) {
        self.objects = objects
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Cell.identifier,
            for: indexPath
        ) as? Cell else { return UITableViewCell() }
        cell.configure(object: objects[indexPath.row])
        return cell
    }
    
    // MARK: - Public methods
    
    /// Обновление объектов в таблице, если переданные данные отличаются от уже имеющихся.
    /// - Parameter objects: Массив объектов для обновления.
    func updateData(objects: [Object]) {
        if self.objects != objects {
            self.objects = objects
            delegate?.needReloadData()
        }
    }
}

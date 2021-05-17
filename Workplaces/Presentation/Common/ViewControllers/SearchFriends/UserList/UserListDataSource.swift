//
//  UserListDataSource.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.05.2021.
//

import UIKit

// MARK: - Protocols

protocol UserListDataSourceDelegate: AnyObject {
    /// Оповещение делегата о необходимости обновления данных.
    func needUpdateUserList()
    /// Нажата кнопка добавления друга в списке пользователей.
    /// - Parameter userID: ID добавляемого пользователя.
    func didTapAddFriend(withID userID: User.ID)
}

final class UserListDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Public properties
    
    var isEmptyData: Bool {
        users.isEmpty
    }
    weak var delegate: UserListDataSourceDelegate?
    
    // MARK: - Private properties
    
    private var users = [User]()
    
    // MARK: - Initializers
    
    init(delegate: UserListDataSourceDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserCell.identifier,
            for: indexPath
        ) as? UserCell else { return UITableViewCell() }
        cell.configure(user: users[indexPath.row], delegate: self)
        return cell
    }
    
    // MARK: - Public methods
    
    /// Обновление пользователей в таблице, если переданные данные отличаются от уже имеющихся.
    /// - Parameter users: Массив пользователей для обновления.
    func updateData(users: [User]) {
        if self.users != users {
            self.users = users
            delegate?.needUpdateUserList()
        }
    }
}

// MARK: - SearchFriendCellDelegate

extension UserListDataSource: UserCellDelegate {
    
    func didTapAddFriend(withID userID: User.ID) {
        delegate?.didTapAddFriend(withID: userID)
    }
}

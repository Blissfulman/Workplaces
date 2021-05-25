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
        foundUsers.isEmpty
    }
    var profileID: User.ID?
    
    // MARK: - Private properties
    
    private weak var delegate: UserListDataSourceDelegate?
    private var foundUsers = [User]()
    private var friendList = [User]()
    
    // MARK: - Initializers
    
    init(delegate: UserListDataSourceDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foundUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserCell.identifier,
            for: indexPath
        ) as? UserCell else { return UITableViewCell() }
        let isAddable = checkAddabilityToFriends(ofUser: foundUsers[indexPath.row])
        cell.configure(user: foundUsers[indexPath.row], delegate: self, isAddable: isAddable)
        return cell
    }
    
    // MARK: - Public methods
    
    /// Обновление пользователей в таблице, если переданные данные отличаются от уже имеющихся.
    /// - Parameter users: Массив пользователей для обновления.
    func updateData(users: [User]) {
        if self.foundUsers != users {
            self.foundUsers = users
            delegate?.needUpdateUserList()
        }
    }
    
    /// Обновление списка друзей, если переданные данные отличаются от уже имеющихся.
    /// - Parameter friendList: Список друзей для обновления.
    func updateFriendList(friendList: [User]) {
        if self.friendList != friendList {
            self.friendList = friendList
            delegate?.needUpdateUserList()
        }
    }
    
    // MARK: - Private methods
    
    private func checkAddabilityToFriends(ofUser user: User) -> Bool {
        !friendList.map { $0.id }.contains(user.id) && (user.id != profileID)
    }
}

// MARK: - SearchFriendCellDelegate

extension UserListDataSource: UserCellDelegate {
    
    func didTapAddFriend(withID userID: User.ID) {
        delegate?.didTapAddFriend(withID: userID)
    }
}

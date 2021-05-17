//
//  ProfileFriendsDataSource.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 13.05.2021.
//

import UIKit

// MARK: - Protocols

protocol ProfileFriendsDataSourceDelegate: AnyObject {
    /// Оповещение делегата о необходимости обновления данных.
    func needUpdateFriendList()
    /// Нажата кнопка поиска друзей внизу таблицы друзей.
    func didTapFindMoreFriendsButton()
    /// Нажата кнопка удаления друга из списка в таблице друзей.
    /// - Parameter userID: ID удаляемого пользователя.
    func didTapDeleteFriend(withID userID: User.ID)
}

final class ProfileFriendsDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Public properties
    
    var isEmptyData: Bool {
        friends.isEmpty
    }
    weak var delegate: ProfileFriendsDataSourceDelegate?
    
    // MARK: - Private properties
    
    private var friends = [User]()
    
    // MARK: - Initializers
    
    init(delegate: ProfileFriendsDataSourceDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isEmptyData ? friends.count : friends.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == friends.count {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FriendListLastCell.identifier,
                for: indexPath
            ) as? FriendListLastCell else { return UITableViewCell() }
            cell.configure(delegate: self)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FriendCell.identifier,
                for: indexPath
            ) as? FriendCell else { return UITableViewCell() }
            cell.configure(user: friends[indexPath.row], delegate: self)
            return cell
        }
    }
    
    // MARK: - Public methods
    
    /// Обновление друзей в таблице, если переданные данные отличаются от уже имеющихся.
    /// - Parameter friends: Массив друзей для обновления.
    func updateData(friends: [User]) {
        if self.friends != friends {
            self.friends = friends
            delegate?.needUpdateFriendList()
        }
    }
}

// MARK: - FriendCellDelegate

extension ProfileFriendsDataSource: FriendCellDelegate {
    
    func didTapDeleteFriend(withID userID: User.ID) {
        delegate?.didTapDeleteFriend(withID: userID)
    }
}

// MARK: - FriendListLastCellDelegate

extension ProfileFriendsDataSource: FriendListLastCellDelegate {
    
    func didTapFindMoreFriendsButton() {
        delegate?.didTapFindMoreFriendsButton()
    }
}

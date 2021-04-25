//
//  ProfileService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Foundation

protocol ProfileService {
    
    typealias UserResultHandler = ResultHandler<User>
    typealias UsersResultHandler = ResultHandler<[User]>
    typealias PostsResultHandler = ResultHandler<[Post]>
    
    func fetchMyProfile(completion: @escaping UserResultHandler)
    func updateMyProfile(user: User, completion: @escaping UserResultHandler)
    func fetchMyPosts(completion: @escaping PostsResultHandler)
    func fetchLikedPosts(completion: @escaping PostsResultHandler)
    func fetchFriendList(completion: @escaping UsersResultHandler)
    func addFriend(userID: String)
    func removeFriend(userID: String)
}

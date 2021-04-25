//
//  ProfileService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Foundation

protocol ProfileService {
    func fetchMyProfile(completion: @escaping (Result<User, Error>) -> Void)
    func updateMyProfile(user: User, completion: @escaping (Result<User, Error>) -> Void)
    func fetchMyPosts(completion: @escaping (Result<[Post], Error>) -> Void)
    func fetchLikedPosts(completion: @escaping (Result<[Post], Error>) -> Void)
    func fetchFriendList(completion: @escaping (Result<[User], Error>) -> Void)
    func addFriend(userID: String)
    func removeFriend(userID: String)
    func newPost(post: Post)
}

//
//  ProfileService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import WorkplacesAPI

protocol ProfileService {
    
    typealias User = WorkplacesAPI.User
    typealias Post = WorkplacesAPI.Post
    typealias UserResultHandler = ResultHandler<User>
    typealias UserListResultHandler = ResultHandler<[User]>
    typealias PostListResultHandler = ResultHandler<[Post]>
    
    func fetchMyProfile(completion: @escaping UserResultHandler)
    func updateMyProfile(user: User, completion: @escaping UserResultHandler)
    func fetchMyPosts(completion: @escaping PostListResultHandler)
    
    @discardableResult
    func fetchLikedPosts(completion: @escaping PostListResultHandler) -> Progress 
    func fetchFriendList(completion: @escaping UserListResultHandler)
    func addFriend(userID: String)
    func removeFriend(userID: String)
}

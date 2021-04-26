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
    
    @discardableResult
    func fetchMyProfile(completion: @escaping UserResultHandler) -> Progress
    
    @discardableResult
    func updateMyProfile(user: User, completion: @escaping UserResultHandler) -> Progress
    
    @discardableResult
    func fetchMyPosts(completion: @escaping PostListResultHandler) -> Progress
    
    @discardableResult
    func fetchLikedPosts(completion: @escaping PostListResultHandler) -> Progress
    
    @discardableResult
    func fetchFriendList(completion: @escaping UserListResultHandler) -> Progress
    
    @discardableResult
    func addFriend(userID: String, completion: @escaping VoidResultHandler) -> Progress
    
    @discardableResult
    func removeFriend(userID: String, completion: @escaping VoidResultHandler) -> Progress
}

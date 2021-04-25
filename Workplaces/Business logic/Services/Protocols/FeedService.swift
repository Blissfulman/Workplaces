//
//  FeedService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Foundation

protocol FeedService {
    func fetchFeedPosts(completion: @escaping (Result<[Post], Error>) -> Void)
    func likePost()
    func unlikePost()
}

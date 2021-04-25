//
//  FeedService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Foundation

protocol FeedService {
    
    typealias PostsResultHandler = ResultHandler<[Post]>
    
    func fetchFeedPosts(completion: @escaping PostsResultHandler)
    func likePost()
    func unlikePost()
}

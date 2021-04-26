//
//  NewPostService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import WorkplacesAPI

protocol NewPostService {
    typealias Post = WorkplacesAPI.Post
    
    func publishPost(post: Post)
}

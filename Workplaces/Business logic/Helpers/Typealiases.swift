//
//  Typealiases.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import WorkplacesAPI

typealias VoidBlock = (() -> Void)
typealias ResultHandler<T> = (Result<T, Error>) -> Void
typealias VoidResultHandler = ResultHandler<Void>

// Модели и классы из WorkplacesAPI
typealias User = WorkplacesAPI.User
typealias Post = WorkplacesAPI.Post
typealias UserCredentials = WorkplacesAPI.UserCredentials
typealias AuthorizationData = WorkplacesAPI.AuthorizationData
typealias AuthDataStorage = WorkplacesAPI.AuthDataStorage

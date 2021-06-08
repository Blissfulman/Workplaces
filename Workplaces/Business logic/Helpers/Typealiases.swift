//
//  Typealiases.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import WorkplacesAPI

typealias VoidBlock = (() -> Void)
public typealias ResultHandler<T> = (Result<T, Error>) -> Void
typealias VoidResultHandler = ResultHandler<Void>

// Модели и классы из WorkplacesAPI
typealias User = WorkplacesAPI.User
typealias Post = WorkplacesAPI.Post
typealias UserCredentials = WorkplacesAPI.UserCredentials
public typealias AuthorizationData = WorkplacesAPI.AuthorizationData
public typealias SecurityManager = WorkplacesAPI.SecurityManager
typealias ProtectionState = WorkplacesAPI.ProtectionState
public typealias TokenRefreshService = WorkplacesAPI.TokenRefreshService

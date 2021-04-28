//
//  Typealiases.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

typealias VoidBlock = (() -> Void)
typealias ResultHandler<T> = (Result<T, Error>) -> Void
typealias VoidResultHandler = ResultHandler<Void>

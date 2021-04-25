//
//  Coordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

protocol Coordinator {
    
    /// Действие по окончании работы координатора.
    var onFinish: VoidBlock { get set }
    
    /// Запуск работы координатора.
    func start()
}

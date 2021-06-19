//
//  TimeManagerImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.06.2021.
//

import Foundation

final class TimeManagerImpl: TimeManager {
    
    // MARK: - Private properties
    
    private var savedTime: DispatchTime?
    
    // MARK: - Public methods
    
    func saveTime() {
        savedTime = .now()
    }
    
    func getElapsedTime() -> Int {
        guard let savedTime = savedTime else { return 0 }
        
        let elapsedTime = savedTime.distance(to: DispatchTime.now())
        guard case let .nanoseconds(nanoseconds) = elapsedTime else { return 0 }
        
        let seconds = nanoseconds / 1_000_000_000
        return seconds
    }
}

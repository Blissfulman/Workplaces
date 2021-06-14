//
//  UploadPost.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import UIKit

public struct UploadPost {
    
    // MARK: - Nested types
    
    public struct Location {
        let longitude: Double
        let latitude: Double
        
        public init(longitude: Double, latitude: Double) {
            self.longitude = longitude
            self.latitude = latitude
        }
    }
    
    // MARK: - Public properties
    
    let text: String
    let imageURL: URL?
    let location: Location?
    
    // MARK: - Initializers
    
    public init(text: String, imageURL: URL?, location: Location?) {
        self.text = text
        self.imageURL = imageURL
        self.location = location
    }
}

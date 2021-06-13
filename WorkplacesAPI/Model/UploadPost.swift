//
//  UploadPost.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import UIKit

public struct UploadPost: Encodable {
    
    // MARK: - Nested types
    
    private enum CodingKeys: String, CodingKey {
        case text
        case imageFile
        case longitude = "lon"
        case latitude = "lat"
    }
    
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
    let imageFile: String
    let longitude: String
    let latitude: String
    
    // MARK: - Initializers
    
    public init(text: String, imageData: Data?, location: Location?) {
        self.text = text
        if let imageData = imageData,
           let base64Data = UIImage(data: imageData)?.pngData()?.base64EncodedData(),
           let stringData = String(data: base64Data, encoding: .utf8) {
            imageFile = stringData
        } else {
            imageFile = ""
        }
        if let location = location {
            self.longitude = String(describing: location.longitude)
            self.latitude = String(describing: location.longitude)
        } else {
            self.longitude = ""
            self.latitude = ""
        }
    }
}

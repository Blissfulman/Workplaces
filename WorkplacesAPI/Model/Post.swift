//
//  Post.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

public struct Post: Identifiable, Codable {
    
    public let id: String
    let text: String?
    let imageURL: URL?
    let longitude: Double?
    let latitude: Double?
    let author: User
    let likes: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case imageURL = "imageUrl"
        case longitude = "lon"
        case latitude = "lat"
        case author
        case likes
    }
    
    init(id: String, text: String?, imageURL: URL, longitude: Double?, latitude: Double?, author: User, likes: Int) {
        self.id = id
        self.text = text
        self.imageURL = imageURL
        self.longitude = longitude
        self.latitude = latitude
        self.author = author
        self.likes = likes
    }
}

public extension Post {
    
    /// Возвращает экземпляр `Post` для тестов.
    static func testPost() -> Self {
        Post(
            id: "test",
            text: "test",
            imageURL: URL(string: "https://redmadrobot.com/")!,
            longitude: 0,
            latitude: 0,
            author: User.testUser(),
            likes: 0
        )
    }
}

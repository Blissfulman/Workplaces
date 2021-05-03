//
//  Post.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

public struct Post: Identifiable, Codable {
    
    public let id: String
    public let text: String?
    public let imageURL: URL?
    public let longitude: Double?
    public let latitude: Double?
    public let author: User
    public let likes: Int
    public let liked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case imageURL = "imageUrl"
        case longitude = "lon"
        case latitude = "lat"
        case author
        case likes
        case liked
    }
    
    init(
        id: String,
        text: String?,
        imageURL: URL,
        longitude: Double?,
        latitude: Double?,
        author: User,
        likes: Int,
        liked: Bool
    ) {
        self.id = id
        self.text = text
        self.imageURL = imageURL
        self.longitude = longitude
        self.latitude = latitude
        self.author = author
        self.likes = likes
        self.liked = liked
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
            likes: 0,
            liked: true
        )
    }
}

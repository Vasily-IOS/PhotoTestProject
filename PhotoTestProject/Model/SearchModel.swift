//
//  SearchModel.swift
//  PhotoTestProject
//
//  Created by Василий on 23.01.2022.
//

import Foundation

struct SearchModel: Decodable {
    var total: Int
    var total_pages: Int
    var results: [Results]
}

struct Results: Decodable {
    var created_at: String
    var urls: URLs
    var likes: Int
    var user: Users
}

struct URLs: Decodable {
    var regular: String
}

struct Users: Decodable {
    var name: String
    var location: String?
    var profile_image: ProfileUrl
}

struct ProfileUrl: Decodable {
    var large: String
}

//struct PhotoModel: Decodable {
//    var created_at: String
//    var urls: Photo
//    var user: User
//    var downloads: Int
//}
//
//struct Photo: Decodable {
//    var regular: String
//}
//
//struct User: Decodable {
//    var name: String
//    var location: String?
//    var profile_image: URLs
//}
//
//struct URLs: Decodable {
//    var large: String
//}


//
//  SearchModel.swift
//  PhotoTestProject
//
//  Created by Василий on 23.01.2022.
//

import Foundation

struct PhotoModel: Decodable {
    var total: Int
    var total_pages: Int
    var results: [Photo]
}

struct Photo: Decodable {
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

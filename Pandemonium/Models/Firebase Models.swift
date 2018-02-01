//
//  Firebase Models.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import Foundation

//typealias postUID = String
//typealias userUID = String
//typealias commentUID = String
//typealias imageUID = String

struct Parrot: Codable {
    let userUID: String?
    var appUserName: String
    var upvotes: Int?
    var downvotes: Int?
    var numberOfComments: Int?
    var image: String?
    var posts: [String : Post]
    func toJSON() -> Any {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
}

struct Post: Codable {
    let postUID: String
    let userUID: String
    let date: String
    var title: String
    var upvotes: Int
    var downvotes: Int
    var tags: [String]
    var bodyText: String?
    var url: String?
    var image: String?
    var comments: [String: Comment]
}


struct Comment: Codable {
    let commentUID: String
    let userUID: String
    let postUID: String
    let date: String
    var commentText: String
    var upvotes: Int
    var downvotes: Int
}

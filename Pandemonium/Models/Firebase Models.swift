//
//  Firebase Models.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import Foundation

typealias postUID = String
typealias userUID = String
typealias commentUID = String
typealias imageUID = String

struct User: Codable {
    let userUID: userUID
    var firstName: String
    var lastName: String
    var appUserName: String
    var email: String
    var upvotes: Int
    var downvotes: Int
    var numberOfComments: Int
    var image: imageUID
    var posts: [postUID : Post]
}

struct Post: Codable {
    let postUID: postUID
    let userUID: userUID
    let date: String
    var title: String
    var upvotes: Int
    var downvotes: Int
    var tags: [String]
    var bodyText: String?
    var url: String?
    var image: imageUID?
    var comments: [commentUID: Comment]
}

struct Comment: Codable {
    let commentUID: commentUID
    let userUID: userUID
    let postUID: postUID
    let date: String
    var commentText: String
    var upvotes: Int
    var downvotes: Int
}

//
//  Post.swift
//  cuncurrency
//
//  Created by admin on 2024/02/25.
//

import Foundation

//https://jsonplaceholder.typicode.com/users/1/posts

struct Post: Codable, Identifiable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}

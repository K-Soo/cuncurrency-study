//
//  User.swift
//  cuncurrency
//
//  Created by admin on 2024/02/25.
//

import Foundation
//https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable {
  let id : Int
  let name: String
  let username: String
  let email: String
}

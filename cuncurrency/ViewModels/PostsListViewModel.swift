//
//  PostsListViewModel.swift
//  cuncurrency
//
//  Created by admin on 2024/02/25.
//

import Foundation


class PostsListViewModel: ObservableObject {
  @Published var posts: [Post] = []
  @Published var isLoading = false
  @Published var showAlert = false
  @Published var errorMessage: String?
//ghi

  var userId: Int?

  func fetchPosts() {
    if let userId = userId {
      let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
      self.isLoading = true




        apiService.getJSON { (result: Result<[Post], APIError>) in
          defer {
            DispatchQueue.main.async {
              self.isLoading = false
            }
          }
          switch result {
          case .success(let post):
            DispatchQueue.main.async {
              self.posts = post
            }
          case .failure(let error):

            DispatchQueue.main.async {
              print(error)
              self.showAlert = true
              self.errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and the steps to reproduce."
            }
          }
        }

    }
  }
}


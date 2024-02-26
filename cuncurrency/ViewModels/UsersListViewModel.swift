//
//  UsersListViewModel.swift
//  cuncurrency
//
//  Created by admin on 2024/02/25.
//

import Foundation

class UsersListViewModel: ObservableObject {
  @Published var users: [User] = []
  @Published var isLoading = false
  @Published var showAlert = false
  @Published var errorMessage: String?

  init() {
    fetchUsers()
  }
  
  func fetchUsers() {
    let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
    self.isLoading = true
    
    apiService.getJSON { (result: Result<[User], APIError>) in
      defer {
        DispatchQueue.main.async {
          self.isLoading = false
        }
      }
      switch result {
      case .success(let users):
        DispatchQueue.main.async {
          self.users = users
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

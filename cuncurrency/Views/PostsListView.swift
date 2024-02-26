//
//  PostsListView.swift
//  cuncurrency
//
//  Created by admin on 2024/02/25.
//

import SwiftUI

struct PostsListView: View {
  @StateObject var vm = PostsListViewModel()
  var userId: Int?

    var body: some View {
      List {
        ForEach(vm.posts) { post in
          VStack(alignment: .leading) {
            Text(post.title)
              .font(.headline)
            Text(post.body)
              .font(.callout)
              .foregroundStyle(.secondary)
          }
        }
      }
      .overlay(content: {
        if vm.isLoading {
          ProgressView()
        }
      })
      .alert("Application error", isPresented: $vm.showAlert, actions: {
        Button("Ok") {}
      }, message: {
        if let errorMessage = vm.errorMessage {
          Text(errorMessage)
        }
      })
      .navigationTitle("Posts")
      .navigationBarTitleDisplayMode(.inline)
      .listStyle(.plain)
      .onAppear {
        vm.userId = userId
        vm.fetchPosts()
      }
    }
}

#Preview {
  NavigationStack {
    PostsListView(userId: 1)
  }
}

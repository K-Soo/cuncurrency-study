//
//  UsersListView.swift
//  cuncurrency
//
//  Created by admin on 2024/02/25.
//

import SwiftUI

struct UsersListView: View {
  @StateObject var vm = UsersListViewModel()

    var body: some View {
        NavigationStack {
          List {
            ForEach(vm.users) { user in
              NavigationLink {
                PostsListView(userId: user.id)
              } label: {
                VStack(alignment: .leading) {
                  Text(user.name)
                    .font(.title)
                  Text(user.email)
                }
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

          .navigationTitle("Users")
          .listStyle(.plain)
          .onAppear {
            vm.fetchUsers()
          }
        }
    }
}

#Preview {
  UsersListView()
}

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserListViewModel
    
    var body: some View {
        NavigationView {
            if !viewModel.isGridView {
                List(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        HStack {
                            UserImage(user: user, frameSize: 50)
                            
                            VStack(alignment: .leading) {
                                Text("\(user.name.first) \(user.name.last)")
                                    .font(.headline)
                                Text("\(user.dob.date)")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onAppear {
                        if viewModel.shouldLoadMoreData(currentItem: user) {
                            viewModel.fetchUsers()
                        }
                    }
                }
                .navigationTitle("Users")
                .toolbar {
                    ItemsToolbar(viewModel: viewModel)
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(viewModel.users) { user in
                            NavigationLink(destination: UserDetailView(user: user)) {
                                VStack {
                                    UserImage(user: user, frameSize: 150)
                                    
                                    Text("\(user.name.first) \(user.name.last)")
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .onAppear {
                                if viewModel.shouldLoadMoreData(currentItem: user) {
                                    viewModel.fetchUsers()
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Users")
                .toolbar {
                    ItemsToolbar(viewModel: viewModel)
                }
            }
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView()
//    }
//}

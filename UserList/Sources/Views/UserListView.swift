import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserListViewModel
    
    var body: some View {
        NavigationView {
            if !viewModel.isGridView {
                List(viewModel.users) { user in
                    UserNavLink(viewModel: viewModel, user: user) {
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
                }
                .navTitleToolbarStyle(viewModel)
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(viewModel.users) { user in
                            UserNavLink(viewModel: viewModel, user: user) {
                                VStack {
                                    UserImage(user: user, frameSize: 150)
                                    
                                    Text("\(user.name.first) \(user.name.last)")
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                }
                .navTitleToolbarStyle(viewModel)
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchUsers()
            }
        }
    }
}



struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        let  ulvm = UserListViewModel(repository: UserListRepository())

        UserListView(viewModel: ulvm)
    }
}

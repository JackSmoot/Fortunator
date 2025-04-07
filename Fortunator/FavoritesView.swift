import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesManager: FavoritesManager

    var body: some View {
        NavigationView {
            Group {
                if favoritesManager.favorites.isEmpty {
                    Text("No favorites yet.")
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                } else {
                    List {
                        ForEach(favoritesManager.favorites, id: \.self) { quote in
                            Text(quote)
                                .padding(.vertical, 5)
                                .foregroundColor(.green)
                        }
                        .onDelete(perform: favoritesManager.remove)
                    }
                }
            }
            .navigationTitle("Favorite Fortunes")
            .background(Color.black)
        }
    }
}

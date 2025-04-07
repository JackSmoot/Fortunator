import Foundation

class FavoritesManager: ObservableObject {
    @Published var favorites: [String] {
        didSet {
            saveFavorites()
        }
    }

    private let key = "favoriteFortunes"

    init() {
        self.favorites = UserDefaults.standard.stringArray(forKey: key) ?? []
    }

    func add(_ fortune: String) {
        if !favorites.contains(fortune) {
            favorites.append(fortune)
        }
    }

    func remove(at offsets: IndexSet) {
        favorites.remove(atOffsets: offsets)
    }

    private func saveFavorites() {
        UserDefaults.standard.set(favorites, forKey: key)
    }
}

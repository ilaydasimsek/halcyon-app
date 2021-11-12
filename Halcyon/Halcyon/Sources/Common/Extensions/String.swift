import Foundation

extension String {
    func firstLetterCapitalized() -> String {
        let first = String(self.prefix(1)).capitalized
        let other = String(self.dropFirst().lowercased())
        return first + other
    }
}

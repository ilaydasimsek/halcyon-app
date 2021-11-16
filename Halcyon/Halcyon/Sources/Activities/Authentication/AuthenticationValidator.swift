import Foundation

enum ValidationError: Error {

    case notEmpty(_ fieldName: String)
    case notValid(_ fieldName: String)
    case notEnoughCharacters(_ fieldName: String, _ characterCount: Int)

    var errorText: String {
        switch self {
        case .notEmpty(let fieldName):
            return "\(fieldName.firstLetterCapitalized()) can not be empty"
        case .notValid(let fieldName):
            return "Please enter a valid \(fieldName.lowercased())"
        case .notEnoughCharacters(let fieldName, let characterCount):
            return "\(fieldName.firstLetterCapitalized()) should be at least \(characterCount) characters"
        }
    }
    
}

class AuthenticationValidator {

    static func validateEmail(_ email: String) -> ValidationError? {
        let mandatoryCharacters: [Character] = ["@", "."]

        if email.isEmpty {
            return ValidationError.notEmpty("Email")
        }

        for character in mandatoryCharacters {
            if !email.contains(character) {
                return ValidationError.notValid("Email")
            }
        }

        return nil
    }

    static func validatePassword(_ password: String, checkCharacterCount: Bool = false) -> ValidationError? {
        let minPasswordCharaters: Int = 6
        if password.isEmpty {
            return ValidationError.notEmpty("Password")
        } else if checkCharacterCount, password.count < minPasswordCharaters {
            return ValidationError.notEnoughCharacters("Password", minPasswordCharaters)
        }

        return nil
    }
}

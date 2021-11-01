import Foundation

struct ValidationError {
    let errorText: String
}

class AuthenticationValidator {

    static func validateEmail(_ email: String) -> ValidationError? {
        let mandatoryCharacters: [Character] = ["@", "."]

        if email.isEmpty {
            return ValidationError(errorText: "Email can not be empty")
        }

        for character in mandatoryCharacters {
            if !email.contains(character) {
                return ValidationError(errorText: "Please enter a valid email")
            }
        }

        return nil
    }

    static func validatePassword(_ password: String, checkCharacterCount: Bool = false) -> ValidationError? {
        let minPasswordCharaters: Int = 6
        if password.isEmpty {
            return ValidationError(errorText: "Password can not be empty")
        } else if checkCharacterCount, password.count < minPasswordCharaters {
            return ValidationError(errorText: "Password should be at least \(minPasswordCharaters) characters")
        }

        return nil
    }
}

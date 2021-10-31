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

    static func validatePassword(_ password: String, _ passwordAgain: String) -> ValidationError? {
        let minPasswordCharaters: Int = 6
        if (password != passwordAgain) {
            return ValidationError(errorText: "Passwords do not match")
        } else if password.count < minPasswordCharaters {
            return ValidationError(errorText: "Password should be at least \(minPasswordCharaters) characters")
        }

        return nil
    }
}

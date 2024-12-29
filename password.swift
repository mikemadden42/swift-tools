import Foundation

enum PasswordCharacters {
    static let lowercase = "abcdefghijklmnopqrstuvwxyz"
    static let uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static let digits = "0123456789"
    static let specialChars = "!@#$%^&*()-_=+[]{}|;:,.<>?"

    static let all = lowercase + uppercase + digits + specialChars
}

func generateSecurePassword(length: Int) -> String {
    var password = ""

    for _ in 0 ..< length {
        if let randomChar = PasswordCharacters.all.randomElement() {
            password.append(randomChar)
        }
    }

    return password
}

// Get length from command-line argument
let arguments = CommandLine.arguments
if arguments.count > 1, let length = Int(arguments[1]) {
    let securePassword = generateSecurePassword(length: length)
    print(securePassword)
} else {
    print("Usage: swift password_generator.swift <length>")
    print("Example: swift password_generator.swift 16")
}

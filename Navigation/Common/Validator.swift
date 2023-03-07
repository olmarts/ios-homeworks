import UIKit

class Validator {
    
    static func isValidUsername(_ userName: String?) throws -> Bool {
        guard let strToValidate = userName else { throw ValidationError.emptyValue }
        if strToValidate.count == 0 { throw ValidationError.emptyValue }
        
        if Validator.isValidPhoneNumber(strToValidate) != true && Validator.isValidEmail(strToValidate) != true  {
            throw ValidationError.username(error: "The username must be your phone number or email address.")
        }
        return true
    }
    
    /// MARK: Возвращает результат валидации формата пароля. При несоответствии политике поднимается ValidationError со списком всех ошибок.
    static func isValidPassword(_ password: String?, minLenght: Int = 6, minDigits: Int = 1, minLowerCase: Int = 1, minUpperCase: Int = 1, minSpecials: Int = 0) throws -> Bool {
        guard let strToValidate = password else { throw ValidationError.emptyValue }
        if strToValidate.count == 0 { throw ValidationError.emptyValue }
        
        var patterns: [(String, String)] = []
        if minLenght > 0 { patterns.append( ("(?=.{\(minLenght),})", "- at least \(minLenght) characters."))}
        if minDigits > 0 { patterns.append((#"(?=.*\d)"#,  "- at least \(minDigits) digit."))}
        if minLowerCase > 0 { patterns.append((#"(?=.*[a-z])"#, "- at least \(minLowerCase) lowercase letter."))}
        if minUpperCase > 0 { patterns.append((#"(?=.*[A-Z])"#, "- at least \(minUpperCase) uppercase letter."))}
        if minSpecials > 0 { patterns.append((#"[$&+,:;=?@#|'<>.-^*()%!]"#, "- at least \(minSpecials) special character."))}

        var errors: [String] = []
        for (passwordPattern, errorMessage) in patterns {
            let result = strToValidate.range(
                of: passwordPattern,
                options: .regularExpression
            )
            if result == nil { errors.append(errorMessage) }
        }
        if errors.count > 0 {
            errors.insert("The password is invalid:", at: 0)
            throw ValidationError.password(errors: errors) }
        return errors.count == 0
    }
    
    static func isValidPhoneNumber(_ phone: String?) -> Bool {
        guard let strToValidate = phone?.replacingOccurrences(of: "-", with: "") else { return false }
        let phonePattern = #"^(\+?)([\d]{0,3}?)(\(?\d{3}\)?)([\d]{7,9})$"#
        let result = strToValidate.range(
            of: phonePattern,
            options: .regularExpression
        )
        return result != nil
    }
    
    static func isValidEmail(_ email: String?) -> Bool {
        return Validator.validateUrl(email)?.scheme == "mailto" ? true : false
    }
    
    static func validateUrl(_ url: String?) -> URL? {
        guard let strToValidate = url else { return nil }
        
        let linkDetector = try? NSDataDetector(
            types: NSTextCheckingResult.CheckingType.link.rawValue
        )
        
        let rangeOfStrToValidate = NSRange(
            strToValidate.startIndex..<strToValidate.endIndex,
            in: strToValidate
        )
        
        guard let matches = linkDetector?.matches(
            in: strToValidate,
            options: [],
            range: rangeOfStrToValidate
        ) else { return nil }
        
        if matches.count != 1 || matches.first?.range != rangeOfStrToValidate { return nil }
        return matches.first?.url
    }
}


enum ValidationError: Error {
    case emptyValue
    case username(error: String)
    case password(errors: [String])
}

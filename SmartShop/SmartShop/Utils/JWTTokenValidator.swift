import JWTDecode
import Foundation

struct JWTTokenValidator {

    static func validate(_ token: String?) -> Bool {

        guard let token else { return false }

        do {
            let jwt = try decode(jwt: token)

            if let expirationDate = jwt.expiresAt {

                let currentDate = Date()

                if currentDate >= expirationDate {

                    return false
                } else {

                    return true
                }

            } else {

                return false
            }

        } catch {
            
            return false
        }
    }
}

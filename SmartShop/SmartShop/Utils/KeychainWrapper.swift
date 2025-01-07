import SwiftUI
import Security

struct KeychainWrapper<T: Codable> {
    static func set(_ value: T, for key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            let query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: data
            ]

            SecItemDelete(query as CFDictionary)

            let status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                print("errSecSuccess")
            }
        } catch {
            print(error)
        }
    }

    static func get(_ value: T, for key: String) -> T? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        SecItemDelete(query as CFDictionary)

        if status == errSecSuccess, let data = item as? Data {
            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                return value
            } catch {
                print(error)
            }
        }
        return nil
    }

    static func delete(key: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}

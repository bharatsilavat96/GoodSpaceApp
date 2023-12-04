//
//  Network.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 04/12/23.
//

import Foundation

import Foundation

protocol ConnectionManagerDelegate: AnyObject {
    func didCompleteTask(for endpoint: APIEndpoint, with result: Result<Data, Error>)
}

struct APIConfig {
    static let baseURL = "https://api.ourgoodspace.com/api/d2/"
}

class ConnectionManager {
    weak var delegate: ConnectionManagerDelegate?

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }

    init() {}

    func startSession(endpoint: APIEndpoint, method: HTTPMethod, parameters: [String: Any]? = nil) {
        guard var components = URLComponents(string: APIConfig.baseURL + endpoint.rawValue) else { return }

        if method == .get, let params = parameters {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        }

        guard let url = components.url else { return }
        print("Hitting Url : \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if method == .post {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Your_Auth_Token", forHTTPHeaderField: "Authorization")
            request.setValue("Your_Device_ID", forHTTPHeaderField: "device-id")
            request.setValue("Your_Device_Type", forHTTPHeaderField: "device-type")

            if let parameters = parameters {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                } catch {
                    delegate?.didCompleteTask(for: endpoint, with: .failure(error))
                    return
                }
            }
        }

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                self.delegate?.didCompleteTask(for: endpoint, with: .failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "Invalid data", code: 0, userInfo: nil)
                self.delegate?.didCompleteTask(for: endpoint, with: .failure(error))
                return
            }

            self.delegate?.didCompleteTask(for: endpoint, with: .success(data))
        }

        task.resume()
    }
}

enum APIEndpoint: String {
    case getOTP = "auth/v2/login"
    case verifyOTP = "auth/verifyotp"
    case premiumProducts = "manage_products/getInActiveProducts"
    case activePremiumProducts = "manage_products/getActiveProducts"
}

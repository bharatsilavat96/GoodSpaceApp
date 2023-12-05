//
//  LoginViewModel.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import Foundation

class LoginViewModel: ConnectionManagerDelegate {
   
    private let connectionManager: ConnectionManager
    weak var delegate: LoginViewModelDelegate?
    
    init() {
        self.connectionManager = ConnectionManager()
        self.connectionManager.delegate = self
    }
   
    func loginUser(withMobileNumber: String, deviceId: String) {
        let loginApiEndPoint = APIEndpoint.getOTP
        let body: [String: String] = ["number":withMobileNumber,"countryCode":"91"]
        connectionManager.startSession(endpoint: loginApiEndPoint, method: .post, parameters: body, deviceId: deviceId)
    }

    func didCompleteTask(for endpoint: APIEndpoint, with result: Result<Data, Error>, deviceId: String) {
        switch result {
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                let signInResponse = try decoder.decode(LoginModel.self, from: data)
                delegate?.didFinishLogin(with: .success(signInResponse))
            } catch let decodingError {
                print("Error decoding JSON: \(decodingError)")
                delegate?.didFinishLogin(with: .failure(decodingError))
            }
        case .failure(let error):
            print("Error fetching data: \(error)")
            delegate?.didFinishLogin(with: .failure(error))
        }
    }
}

protocol LoginViewModelDelegate: AnyObject {
    func didFinishLogin(with result: Result<LoginModel, Error>)
}

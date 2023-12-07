//
//  verifyNumberModelView.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import Foundation

class VerifyNumberViewModel: ConnectionManagerDelegate {
    
    private let connectionManager: ConnectionManager
    weak var delegate: VerifyNumberViewModelDelegate?
    
    init(){
        self.connectionManager = ConnectionManager()
        self.connectionManager.delegate = self
    }
    
    func verifyUser(withMobileNumber: String, otp:String){
        let loginApiEndPoint = APIEndpoint.getOTP
        let body: [String: String] = ["number":withMobileNumber,"countryCode":"91","otp":otp]
        connectionManager.startSession(endpoint: .verifyOTP, method: .post, parameters: body)
    }
    
    func didCompleteTask(for endpoint: APIEndpoint, with result: Result<Data, Error>) {
        switch result {
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                let verifyNumberResponse = try decoder.decode(verifyPhoneNumberModel.self, from: data)
                delegate?.didFinishVerify(with: .success(verifyNumberResponse))
            } catch let decodingError {
                print("Error decoding JSON: \(decodingError)")
                delegate?.didFinishVerify(with: .failure(decodingError))
            }
        case .failure(let error):
            print("Error fetching data: \(error)")
            delegate?.didFinishVerify(with: .failure(error))
        }
    }
}
protocol VerifyNumberViewModelDelegate: AnyObject {
    func didFinishVerify(with result: Result<verifyPhoneNumberModel, Error>)
}


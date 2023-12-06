//
//  JobsViewModel.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 06/12/23.
//

import Foundation

class JobsViewModel: ConnectionManagerDelegate{
    
    private let connectionManager: ConnectionManager
    weak var delegate: JobsViewModelDelegate?
    
    init(connectionManager: ConnectionManager, delegate: JobsViewModelDelegate? = nil) {
        self.connectionManager = connectionManager
        self.delegate = delegate
    }
    
    func getUserData(){
        let token = UserDefaults.value(forKey: "userToken")
        print("\(token)")
        if let token = token {
            connectionManager.startSession(endpoint: .activePremiumProducts, method: .get,parameters: ["token": token])
        }else {
            print("Fetching Token Failed")
        }
    }
    
    func didCompleteTask(for endpoint: APIEndpoint, with result: Result<Data, Error>, deviceId: String) {
        switch result{
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                let jobsResponse = try decoder.decode(JobsModel.self, from: data)
                delegate?.didFinishVerify(with: .success(jobsResponse))
            } catch let decodingError {
                print("Error decoding JSON: \(decodingError)")
                delegate?.didFinishVerify(with: .failure(decodingError))
            }
        case .failure(let error):
            print("Error: \(error)")
        }
    }
    
    
    
    
    
}
protocol JobsViewModelDelegate: AnyObject {
    func didFinishVerify(with result: Result<JobsModel, Error>)
}

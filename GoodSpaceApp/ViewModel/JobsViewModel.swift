//
//  JobsViewModel.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 06/12/23.
//

import Foundation

class JobsViewModel: ConnectionManagerDelegate{
    
    private let connectionManager: ConnectionManager
    weak var delegate: JobsViewModelDeleaget?
    
    init(){
        self.connectionManager = ConnectionManager()
        self.connectionManager.delegate = self
    }
    
    func getUserData(withHeader: [String:String], completion: @escaping () -> Void){

        connectionManager.startSession(endpoint: .jobsList, method: .get,customHeaders: withHeader)

    }
    
    func didCompleteTask(for endpoint: APIEndpoint, with result: Result<Data, Error>) {
        switch result {
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                let verifyNumberResponse = try decoder.decode(ApiResponse.self, from: data)
                delegate?.didFinishFindingJobs(with: .success(verifyNumberResponse))
            } catch let decodingError {
                print("Error decoding JSON: \(decodingError)")
                delegate?.didFinishFindingJobs(with: .failure(decodingError))
            }
        case .failure(let error):
            print("Error fetching data: \(error)")
            delegate?.didFinishFindingJobs(with: .failure(error))
        }
    }
}
protocol JobsViewModelDeleaget: AnyObject {
    func didFinishFindingJobs(with result: Result<ApiResponse, Error>)
}


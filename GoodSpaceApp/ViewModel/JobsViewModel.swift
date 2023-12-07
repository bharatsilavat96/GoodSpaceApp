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
    
    init(){
        self.connectionManager = ConnectionManager()
        self.connectionManager.delegate = self
    }
    
    func getUserData(withDeviceId: String, parameterBody:String){
        
            connectionManager.startSession(endpoint: .activePremiumProducts, method: .get,parameters: ["Authorization": parameterBody])

    }
    
    func didCompleteTask(for endpoint: APIEndpoint, with result: Result<Data, Error>) {
        switch result{
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                let jobsResponse = try decoder.decode(JobModel.self, from: data)
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
    func didFinishVerify(with result: Result<JobModel, Error>)
}

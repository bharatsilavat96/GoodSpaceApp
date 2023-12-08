//
//  InactiveJobsViewModel.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 08/12/23.
//

import Foundation

class InActiveProductsViewModel: ConnectionManagerDelegate{
    
    private let connectionManager: ConnectionManager
    weak var delegate: InActiveJobsViewModelDelegate?
    
    init(){
        self.connectionManager = ConnectionManager()
        self.connectionManager.delegate = self
    }
    
    func getInactiveJobsData(withHeader: [String:String], completion: @escaping () -> Void){
        connectionManager.startSession(endpoint: .premiumProducts, method: .get, customHeaders: withHeader)
    }
    func didCompleteTask(for endpoint: APIEndpoint, with result: Result<Data, Error>) {
        switch result{
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                let inActiveJobsResponse = try decoder.decode(InActiveProductModel.self, from: data)
                delegate?.didFindInActiveProduct(with: .success(inActiveJobsResponse))
            } catch let decodingError {
                print("Error decoding JSON: \(decodingError)")
                delegate?.didFindInActiveProduct(with: .failure(decodingError))
            }
        case .failure(let error):
            print("")
        }
    }
    
}
protocol InActiveJobsViewModelDelegate: AnyObject {
    func didFindInActiveProduct(with result: Result<InActiveProductModel, Error>)
}

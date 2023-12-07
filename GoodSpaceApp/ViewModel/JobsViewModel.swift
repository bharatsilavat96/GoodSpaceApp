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
    var decodedData: [String: Any]?
    
    init(){
        self.connectionManager = ConnectionManager()
        self.connectionManager.delegate = self
    }
    
    func getUserData(withHeader: [String:String]){

        connectionManager.startSession(endpoint: .jobsList, method: .get,customHeaders: withHeader)

    }
    
    func didCompleteTask(for endpoint: APIEndpoint, with result: Result<Data, Error>) {
        switch result{
        case .success(let data):
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    decodedData = jsonObject
                    delegate?.didFinishVerify(with: decodedData!)
                }
            } catch{
                print("decodingError")
            }
        case .failure(let error):
            print("Error: \(error)")
        }
    }
}
protocol JobsViewModelDelegate: AnyObject {
    func didFinishVerify(with result: [String:Any])
}

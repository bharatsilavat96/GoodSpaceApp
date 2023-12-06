//
//  WorkViewController.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import UIKit

class WorkViewController: UIViewController,JobsViewModelDelegate {
    
    @IBOutlet weak var futureCollectionView: UICollectionView!
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var jobSearchBar: UISearchBar!
    
    private var jobsViewModel: JobsViewModel?
    private var deviceId: String?
    private var autherisationCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    func didFinishVerify(with result: Result<Datum, Error>) {
        switch result {
        case .success(let data):
            print("Comapny Name :",data.cardData?.companyName)
        case .failure(let error):
            print("Error: \(error)")
        }
    }
    private func setupUI(){
        deviceId = getDeviceID()
        futureCollectionView.dataSource = self
        futureCollectionView.delegate = self
        jobsTableView.delegate = self
        jobsTableView.dataSource = self

        // Initialize the jobsViewModel
        jobsViewModel = JobsViewModel()
        jobsViewModel?.delegate = self
        autherisationCode =  UserDefaults.standard.string(forKey: "UserToken")
        print("Device Id : ---\(deviceId)")
        print("AutheriztionCode :\(autherisationCode)")
        
    
        if let deviceId = deviceId, let autherisationCode = autherisationCode {
            jobsViewModel?.getUserData(withDeviceId: deviceId, parameterBody: autherisationCode)
        }else {
            print("Error Getting DeviceId and Access Token")
        }
        
    }
    func getDeviceID() -> String {
        if let identifierForVendor = UIDevice.current.identifierForVendor {
            return identifierForVendor.uuidString
        } else {
            return "Unknown"
        }
    }
}
extension WorkViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FutureCollectionViewCell", for: indexPath) as! FutureCollectionViewCell
        cell.layer.masksToBounds = true
        cell.roundCorners(5, borderWidth: 1, borderColor: UIColor(hex: "#297BCA"))
        return cell
    }
}

extension WorkViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 140
        )
    }
}
extension WorkViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTableViewCell", for: indexPath) as! JobsTableViewCell
        cell.contentView.roundCorners(10, borderWidth: 1, borderColor: UIColor(hex: "#C4C4C466",alpha: 0.4))
        cell.separatorInset.bottom
        return cell
    }
}
extension WorkViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let spaceBetweenCells: CGFloat = 10.0
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: spaceBetweenCells, right: 0))
    }
    
}

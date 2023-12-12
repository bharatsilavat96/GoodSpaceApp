//
//  WorkViewController.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import UIKit

class WorkViewController: UIViewController,JobsViewModelDeleaget, InActiveJobsViewModelDelegate {
    
    @IBOutlet weak var futureCollectionView: UICollectionView!
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var jobSearchBar: UISearchBar!
    
    private var jobsViewModel: JobsViewModel?
    private var inActiveViewModel: InActiveProductsViewModel?
    private var authorization: String?
    private var jobData: [Job]?
    private var premioumFeature: [ProductData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        
        authorization = UserDefaultsManager.shared.getAuthToken()
        jobsViewModel = JobsViewModel()
        jobsViewModel?.delegate = self
        inActiveViewModel = InActiveProductsViewModel()
        inActiveViewModel?.delegate = self
        
        futureCollectionView.dataSource = self
        futureCollectionView.delegate = self
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleApiafterSecond()
    }
    
    func handleApiafterSecond() {
        // Create a DispatchGroup
        let dispatchGroup = DispatchGroup()
        
        if let authorization = authorization {
            let customHeader = ["Authorization": authorization]
            
            dispatchGroup.enter()
            jobsViewModel?.getUserData(withHeader: customHeader) {
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            inActiveViewModel?.getInactiveJobsData(withHeader: customHeader) {
                dispatchGroup.leave()
            }
        } else {
            print("Error Getting Access Token")
        }
        dispatchGroup.notify(queue: .main) {
            print("Both API calls are completed")
        }
    }
    
    
    func didFindInActiveProduct(with result: Result<InActiveProductModel, Error>) {
        switch result {
        case .success(let data):
//            print(data.data?[0].displayName)
            premioumFeature = data.data
            DispatchQueue.main.async {
                self.futureCollectionView.reloadData()
            }
//            jobData = data.
        case .failure(let error):
            print("Error: \(error)")
        }
    }
    
    func didFinishFindingJobs(with result: Result<ApiResponse, Error>) {
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                self.jobsTableView.reloadData()
            }
            jobData = data.data
        case .failure(let error):
            print("Error: \(error)")
        }
    }
    
    
}
extension WorkViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return premioumFeature?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FutureCollectionViewCell", for: indexPath) as! FutureCollectionViewCell
        cell.candidateNameLabe.text = premioumFeature?[indexPath.row].displayName
        cell.candidateProfileNameLabel.text = premioumFeature?[indexPath.row].productName
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTableViewCell", for: indexPath) as! JobsTableViewCell
        cell.contentView.roundCorners(10, borderWidth: 1, borderColor: UIColor(hex: "#C4C4C466",alpha: 0.4))
        let getToData = jobData?[indexPath.row].cardData
        cell.addressLabel.text = getToData?.locationCity
        cell.companyNameLabel.text = getToData?.companyName
        cell.jobProfileLabel.text = getToData?.title
        cell.monthlyCompensationLabel.text = getToData?.displayCompensation
        cell.userNameLabel.text = getToData?.userInfo.name
        cell.uploadedDateLabel.text = getToData?.postedAtRelative
        if let imageURLString = getToData?.userInfo.imageID {
                ImageDownloader.downloadImage(imageURLString) { (image, _) in
                    DispatchQueue.main.async {
                        cell.userProfileImageView.image = image
                        cell.setNeedsLayout()
                    }
                }
            }
        
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

//
//  JobsTableViewCell.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 06/12/23.
//

import UIKit

class JobsTableViewCell: UITableViewCell {


    @IBOutlet weak var jobProfileLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var uploadedDateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var monthlyCompensationLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var isRemoteLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var monthyCompensationView: UIView!
    @IBOutlet weak var isLikedView: UIView!
    @IBOutlet weak var isRemoteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        userProfileImageView.roundCorners(18, borderWidth: 0, borderColor: .clear)
        monthyCompensationView.roundCorners(3, borderWidth: 1, borderColor: UIColor(hex: "#1E9915"))
        monthlyCompensationLabel.textColor = UIColor(hex: "#1E9915")
        isLikedView.roundCorners(3, borderWidth: 1, borderColor: UIColor(hex: "#026AA2"))
        experienceLabel.textColor = UIColor(hex: "#026AA2")
        isRemoteView.roundCorners(3, borderWidth: 1, borderColor: UIColor(hex: "#6172F3BA"))
        isRemoteLabel.textColor = UIColor(hex: "#6172F3BA")
        applyButton.roundCorners(5, borderWidth: 0, borderColor: .clear)
        
    }

}
/*
 "monthly_compensation": "₹25k - 50k",
 "location_city"
 "is_remote": 0,
 "companyName": "AppSmartz",
 "title": "Ios Developer",
 "designation": "Ios Developer",
 "date": "2023-10-18 14:08:25",
 "hasApplied": false,
 "jobSaved": false,
 "postedAtRelative": "2 months ago",
 "hasLiked": false,
 "name": "Madhuri",
 "image_id"
 "isProfileVerified": false
 */

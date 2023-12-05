//
//  CustomNavigationViewController.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import UIKit

class CustomNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButtonImage = UIImage(named: "ep_back")?.withTintColor(.black)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: nil, action: nil)
        backButton.tintColor = .gray
        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for: .default)
        
        // Create a custom button on the right
        let rightButton = UIBarButtonItem(image: UIImage(named: "icon-edit-2"), style: .plain, target: self, action: #selector(rightButtonTapped))
        
        // Create a custom label on the left
        let label = UILabel()
        label.text = "Edit phone number"
        label.textColor = UIColor(hex: "#6D6E71")
        label.textColor = .black
        let leftButton = UIBarButtonItem(customView: label)
        
        // Set the buttons in the navigation bar
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    @objc func rightButtonTapped() {
        // Handle the right button tap action
    }
}

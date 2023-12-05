//
//  DashBoardViewController.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import UIKit

class DashBoardViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = self.tabBar
        tabBar.barTintColor = .white
        tabBar.tintColor = UIColor(hex: "#389FFF")
        setupTabBar()
        tabBar.backgroundColor = UIColor.white
    }
    private func setupTopView() {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topView)
        
        let circularProgressBar = CircularProgressBar(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
        circularProgressBar.translatesAutoresizingMaskIntoConstraints = false
        circularProgressBar.setProgress(0.30)
        topView.addSubview(circularProgressBar)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 17 // Adjust the radius to half of the circularProgressBar's width
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "Ellipse") // Replace with your image name
        topView.addSubview(imageView)
        
        let button1 = UIButton()
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.setImage(UIImage(named: "basil_diamond-outline"), for: .normal)
        topView.addSubview(button1)
        
        let button2 = UIButton()
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.setImage(UIImage(named: "icon-bell"), for: .normal)
        topView.addSubview(button2)
        
        let button3 = UIButton()
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.setImage(UIImage(named: "icon-align-left"), for: .normal)
        topView.addSubview(button3)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50),

            circularProgressBar.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 8),
            circularProgressBar.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            circularProgressBar.widthAnchor.constraint(equalToConstant: 34),
            circularProgressBar.heightAnchor.constraint(equalToConstant: 34),

            imageView.centerXAnchor.constraint(equalTo: circularProgressBar.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: circularProgressBar.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 34),
            imageView.heightAnchor.constraint(equalToConstant: 34),

            button1.trailingAnchor.constraint(equalTo: button2.leadingAnchor, constant: -8),
            button1.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            button1.widthAnchor.constraint(equalToConstant: 34),
            button1.heightAnchor.constraint(equalToConstant: 34),

            button2.trailingAnchor.constraint(equalTo: button3.leadingAnchor, constant: -8),
            button2.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            button2.widthAnchor.constraint(equalToConstant: 34),
            button2.heightAnchor.constraint(equalToConstant: 34),

            button3.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            button3.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            button3.widthAnchor.constraint(equalToConstant: 34),
            button3.heightAnchor.constraint(equalToConstant: 34)
        ])
    }


    private func setupTabBar(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "WorkViewController") as! WorkViewController
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "RecruitViewController") as! RecruitViewController
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: "SocialViewController") as! SocialViewController
        let fourthViewController = storyboard.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
        let fifthViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        
        firstViewController.tabBarItem = UITabBarItem(title: "Work", image: UIImage(named: "icon-briefcase 2"), tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: "Recruit", image: UIImage(named: "Frame 1000001691"), tag: 1)
        thirdViewController.tabBarItem = UITabBarItem(title: "Social", image: UIImage(named: "icon-users"), tag: 2)
        fourthViewController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "icons8-message-24"), tag: 3)
        fifthViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "icon-user"), tag: 4)
        
        let controllers = [firstViewController, secondViewController, thirdViewController, fourthViewController, fifthViewController]
        viewControllers = controllers.map({ UINavigationController(rootViewController: $0)})
        
    }
    
}

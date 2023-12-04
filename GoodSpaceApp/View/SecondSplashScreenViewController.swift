//
//  SecondSplashScreenViewController.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import UIKit

class SecondSplashScreenViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(showNextScreen), userInfo: nil, repeats: false)
        self.view.backgroundColor = UIColor(hex: "#399EF7")
    }
    @objc func showNextScreen() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let secondSplashViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                secondSplashViewController.modalPresentationStyle = .overFullScreen
                secondSplashViewController.modalTransitionStyle = .crossDissolve
                present(secondSplashViewController, animated: true, completion: nil)
            }
        }
    
}

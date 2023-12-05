//
//  SignInScreenViewController.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import UIKit

class SignInViewController: UIViewController,LoginViewModelDelegate {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginPageTittleLabel: UILabel!
    @IBOutlet weak var phoneNumberInfolabel: UILabel!
    @IBOutlet weak var otpInfoLabel: UILabel!
    @IBOutlet weak var getOtpButton: UIButton!
    
    private var deviceId : String?
    private var loginViewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    @IBAction func getOTPButtonAction(_ sender: Any) {
        guard let phoneNumber = phoneNumberTextField.text, let deviceId = deviceId else {
            return
        }
        loginViewModel?.loginUser(withMobileNumber: phoneNumber, deviceId: deviceId)
    }

    func getDeviceID() -> String {
        if let identifierForVendor = UIDevice.current.identifierForVendor {
            print(identifierForVendor.uuidString)
            return identifierForVendor.uuidString
        } else {
            return "Unknown"
        }
    }
    
    func didFinishLogin(with result: Result<LoginModel, Error>) {
        switch result {
        case .success(let data):
            print("Data is :\(data.message)")
        case .failure(let error):
            print("Error :\(error)")
        }
    }
}
extension SignInViewController{
    private func setupUI(){
        deviceId = getDeviceID()
        loginViewModel?.delegate = self
    }
}

//
//  SignInScreenViewController.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import UIKit

class SignInViewController: BaseViewController,LoginViewModelDelegate {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginPageTittleLabel: UILabel!
    @IBOutlet weak var phoneNumberInfolabel: UILabel!
    @IBOutlet weak var otpInfoLabel: UILabel!
    @IBOutlet weak var getOtpButton: UIButton!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var seperatorView: UIView!
    
    //MARK: - Variables -
    private var deviceId : String?
    private var loginViewModel: LoginViewModel?
    let highLightedString = "Discover\nDREAM dive in".colored(with: UIColor(hex: "#389FFF"), for: "DREAM")
    let highLightedString2 = "Please enter your phone number to sign in GoodSpace account.".colored(with: UIColor(hex: "#389FFF"), for: "GoodSpace")
    let highlightedStr3 = "You will recieve a 4 digit OTP".colored(with: UIColor(hex: "#389FFF"), for: "4 digit OTP")
    var isKeyboardOpen: Bool = true
    
    //MARK: - ViewDidLoad -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
        
    }
    
    //MARK: - IBActions -
    @IBAction func getOTPButtonAction(_ sender: Any) {
        print("Get Otp Button Tapped")
        guard let phoneNumber = phoneNumberTextField.text, let deviceId = deviceId else {
            return
        }

        if ValidationManager.isValidPhoneNumber(phoneNumber) {
            loginViewModel?.loginUser(withMobileNumber: phoneNumber, deviceId: deviceId)
            let verifyOtpViewController = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTPViewController") as! VerifyOTPViewController
            verifyOtpViewController.mobileNumber = "\(phoneNumber)"
            verifyOtpViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(verifyOtpViewController, animated: true)
        } else {
            print("Phone Number is Invalid")

            // Update UI to indicate an error
            phoneNumberView.roundCorners(10, borderWidth: 1, borderColor: .red)
            otpInfoLabel.text = "Enter Correct phone number"
            seperatorView.backgroundColor = .red
            otpInfoLabel.textColor = UIColor.red
        }
    }

    
    //MARK: - Functions -
    func getDeviceID() -> String {
        if let identifierForVendor = UIDevice.current.identifierForVendor {
            return identifierForVendor.uuidString
        } else {
            return "Unknown"
        }
    }
    
    func didFinishLogin(with result: Result<LoginModel, Error>) {
        switch result {
        case .success(let data):
            print("Successfully received Data at SignInVC")
        case .failure(let error):
            print("Error :\(error)")
        }
    }
    
    private func setupUI(){
        deviceId = getDeviceID()
        loginViewModel = LoginViewModel()
        loginViewModel?.delegate = self
        phoneNumberTextField.delegate = self
        phoneNumberView.layer.masksToBounds = true
        phoneNumberView.roundCorners(10, borderWidth: 1, borderColor: UIColor.systemGray)
        getOtpButton.layer.masksToBounds = true
        getOtpButton.roundCorners(10, borderWidth: 0, borderColor: .clear)
        loginPageTittleLabel.attributedText = highLightedString
        loginPageTittleLabel.textAlignment = .left
        phoneNumberInfolabel.attributedText = highLightedString2
        otpInfoLabel.attributedText = highlightedStr3
//        phoneNumberTextField.addTarget(self, action:#selector(textFieldDidChange), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: Notification) {
        if isKeyboardOpen{
            isKeyboardOpen = false
            
        } else {
        }
        guard let userInfo = notification.userInfo,
              let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        
        let mobileNumberTextFieldY = self.phoneNumberTextField.frame.origin.x + self.phoneNumberTextField.frame.origin.y + self.phoneNumberTextField.frame.size.height
        print("mobileNumberTextFieldY :",mobileNumberTextFieldY)
        let visibleHeight = self.view.frame.size.height - keyboardSize.height
        //        print("Visible Height :",visibleHeight)
        
        if mobileNumberTextFieldY < visibleHeight {
            let yOffset = 0 - keyboardSize.height
            //            print("Y Offset :",yOffset)
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = yOffset
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
}
extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Editing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        // Check if the new text is numeric
        let isNumeric = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        
        // Check if the total length after replacement does not exceed 10 characters
        let newLength = currentText.count + string.count
        let doesNotExceedLimit = newLength <= 10
        
        // Allow only numeric characters and ensure total length does not exceed 10 characters
        return isNumeric && doesNotExceedLimit
    }
    
    func updateColorsForExceedingLimit(_ isExceeding: Bool) {
        if isExceeding {
            phoneNumberView.roundCorners(10, borderWidth: 1, borderColor: .red)
            otpInfoLabel.text = "Enter Correct phone number"
            seperatorView.backgroundColor = .red
            otpInfoLabel.textColor = UIColor.red
        } else {
            otpInfoLabel.textColor = UIColor(hex: "#C4C4C4")
            phoneNumberView.roundCorners(10, borderWidth: 1, borderColor: .gray)
            seperatorView.backgroundColor = UIColor(hex: "#C4C4C466")
            otpInfoLabel.attributedText = highlightedStr3
        }
    }
}

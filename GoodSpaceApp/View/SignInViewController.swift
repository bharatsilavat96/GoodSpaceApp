//
//  SignInScreenViewController.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import UIKit

class SignInViewController: UIViewController,LoginViewModelDelegate {
    
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
        setupUI()
        
    }
    
    //MARK: - IBActions -
    @IBAction func getOTPButtonAction(_ sender: Any) {
        print("Get Otp Button Tapped")
        guard let phoneNumber = phoneNumberTextField.text, let deviceId = deviceId else {
            return
        }
        if ValidationManager.isValidPhoneNumber(phoneNumber){
            loginViewModel?.loginUser(withMobileNumber: phoneNumber, deviceId: deviceId)
            let verifyOtpViewController = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTPViewController") as! VerifyOTPViewController
            verifyOtpViewController.modalPresentationStyle = .overCurrentContext
            self.present(verifyOtpViewController, animated: false)
        }else {
            print("Phone Number is Invalid")
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
            print("Date is ;",data.message)
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
        phoneNumberTextField.addTarget(self, action:#selector(textFieldDidChange), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: Notification) {
        if isKeyboardOpen{
            getOtpButton(with: (self.view.frame.maxY - 60))
            isKeyboardOpen = false
            
        } else {
            //            print("KeyBoard is Not Open Now")
            
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
        
    }
    func getOtpButton(with height: CGFloat) {
        let getOtpButton = UIButton()
        getOtpButton.frame = CGRect(x: 12, y: height, width: view.frame.width - 24, height: 50)
        getOtpButton.setTitle("Send OTP", for: .normal)
        //        getOtpButton.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        getOtpButton.backgroundColor = UIColor(red: 0.004, green: 0.325, blue: 0.271, alpha: 1)
        getOtpButton.titleLabel?.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        getOtpButton.layer.masksToBounds = true
        getOtpButton.layer.cornerRadius = 5.0
        view.addSubview(getOtpButton)
        getOtpButton.addTarget(self, action: #selector(getOtpButtonAction), for: .touchUpInside)
        
    }
    @objc func getOtpButtonAction() {
        
    }
}
extension SignInViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Editing")
    }
    @objc func textFieldDidChange() {
            guard let text = phoneNumberTextField.text else { return }
            let newLength = text.count

            if newLength <= 10 {
                let isNumeric = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: text))

                if isNumeric {
                    if newLength > 9 {
                        updateColorsForExceedingLimit(true)
                    } else {
                        updateColorsForExceedingLimit(false)
                    }
                } else {
                    // Handle the case when the entered string is not numeric
                    print("Invalid input. Please enter numeric characters only.")
                    updateColorsForExceedingLimit(true)
                }
            } else {
                updateColorsForExceedingLimit(true)
            }
        }

        func updateColorsForExceedingLimit(_ isExceeding: Bool) {
            if isExceeding {
                phoneNumberView.roundCorners(10, borderWidth: 1, borderColor: .red)
                otpInfoLabel.text = "Enter Correct phone number"
                seperatorView.backgroundColor = .red
            } else {
                phoneNumberView.roundCorners(10, borderWidth: 1, borderColor: .gray)
                otpInfoLabel.attributedText = highlightedStr3
                seperatorView.backgroundColor = UIColor(hex: "#C4C4C466")
            }
        }
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else { return true }
//        let newLength = text.count + string.count - range.length
//
//        if newLength <= 10 {
//            let isNumeric = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
//
//            if isNumeric {
//                if newLength > 9 {
//                    phoneNumberView.roundCorners(10, borderWidth: 1, borderColor: .red)
//                    otpInfoLabel.text = "Enter Correct phone number"
//                    seperatorView.backgroundColor = .red
//                } else {
//                    phoneNumberView.roundCorners(10, borderWidth: 1, borderColor: .gray)
//                    otpInfoLabel.attributedText = highlightedStr3
//                    seperatorView.backgroundColor = UIColor(hex: "#C4C4C466")
//                }
//            } else {
//                // Handle the case when the entered string is not numeric
//                print("Invalid input. Please enter numeric characters only.")
//            }
//
//            return true
//        } else {
//            // Perform the color update logic here for exceeding 10 characters
//            phoneNumberView.roundCorners(10, borderWidth: 1, borderColor: .red)
//            otpInfoLabel.text = "Enter Correct phone number"
//            seperatorView.backgroundColor = .red
//            return false
//        }
//    }

//}

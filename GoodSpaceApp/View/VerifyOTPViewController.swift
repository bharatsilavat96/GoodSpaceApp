//
//  VerifyOTPViewController.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import UIKit

class VerifyOTPViewController: UIViewController,VerifyNumberViewModelDelegate {
    
    @IBOutlet weak var otpInfoLabel: UILabel!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var otptTmeInfoLabel: UILabel!
    @IBOutlet weak var resendButton:UIButton!
    
    @IBOutlet weak var otpFirstDigitTF: UITextField!
    @IBOutlet weak var otpSecondDigitTF: UITextField!
    @IBOutlet weak var otpThirdDigitTF: UITextField!
    @IBOutlet weak var resendButtonLabel: UILabel!
    @IBOutlet weak var otpFourthDigitTF: UITextField!
    @IBOutlet weak var otpStackTextView: UIStackView!
    
    
    var verifyViewModel : VerifyNumberViewModel?
    private var deviceId : String?
    private var textFiledOtp: String?
    var receivedResponseOtp : Int?
    var mobileNumber: String?
    var isKeyboardOpen: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    @IBAction func verifyButtonAction(_ sender: Any) {
        self.textFiledOtp = "\(self.otpFirstDigitTF.text ?? "")\(self.otpSecondDigitTF.text ?? "")\(self.otpThirdDigitTF.text ?? "")\(self.otpFourthDigitTF.text ?? "")"
        guard let deviceId = deviceId, let textFiledOtp = textFiledOtp else {return}
        verifyViewModel?.verifyUser(withMobileNumber: "9340536820", deviceId: deviceId, otp: textFiledOtp)
        print("Verify Button tapped")
    }
    
    @IBAction func recendOtpButtonAction(_ sender: Any) {
        
    }
    
    func didFinishVerify(with result: Result<verifyPhoneNumberModel, Error>) {
        switch result {
        case .success(let data):
            print(data.data)
            if data.message == "Your OTP has been successfully verified"{
                DispatchQueue.main.async {
                    let verifyOtpViewController = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
    //                verifyOtpViewController.mobileNumber = "\(phoneNumber)"
                    verifyOtpViewController.modalPresentationStyle = .overCurrentContext
                    self.present(verifyOtpViewController, animated: true)
                }
            }else {
                DispatchQueue.main.async {
                    let textFields = [self.otpFirstDigitTF, self.otpSecondDigitTF, self.otpThirdDigitTF, self.otpFourthDigitTF]
                    textFields.forEach({$0?.layer.borderColor = UIColor.red.cgColor})
                    textFields.forEach({$0?.textColor = UIColor.red})
                    textFields.forEach({$0?.backgroundColor = UIColor(hex: "#FAFAFA")})
                    self.resendButton.isHidden = true
                    self.resendButtonLabel.textColor = UIColor.red
                    self.resendButtonLabel.text = "Enter Correct OTP"
                    
                }
            }
        case .failure(let error):
            print("OTP verification Failed :",error)
        }
    }
    
    
    private func setupUI(){
        deviceId = getDeviceID()
        verifyViewModel = VerifyNumberViewModel()
        verifyViewModel?.delegate = self
        let keyBoardType = [otpFirstDigitTF, otpSecondDigitTF, otpThirdDigitTF, otpFourthDigitTF]
        keyBoardType.forEach { $0?.keyboardType = .numbersAndPunctuation }
        keyBoardType.forEach({ $0?.textColor = UIColor.white})
        otptTmeInfoLabel.textColor = UIColor(hex: "#C4C4C4")
        otpInfoLabel.attributedText = "OTP sent to +91 \(mobileNumber ?? "")\nEnter OTP to confirm your phone".colored(with: UIColor(hex: "#389FFF"), for: "\(mobileNumber ?? "")")
        otptTmeInfoLabel.textColor = UIColor(hex: "#C4C4C4")
//        otpInfoLabel.font.withSize(20)
        let delegate = [otpFirstDigitTF, otpSecondDigitTF, otpThirdDigitTF, otpFourthDigitTF]
        delegate.forEach { $0!.delegate = self }
        let layersProperties = [otpFirstDigitTF, otpSecondDigitTF, otpThirdDigitTF, otpFourthDigitTF]
        layersProperties.forEach { $0?.roundCorners(5, borderWidth: 1, borderColor: UIColor(hex: "#389FFF")) }
        verifyButton.roundCorners(10, borderWidth: 0, borderColor: UIColor(hex: "#389FFF"))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func getDeviceID() -> String {
        if let identifierForVendor = UIDevice.current.identifierForVendor {
            return identifierForVendor.uuidString
        } else {
            return "Unknown"
        }
    }
    @objc func keyboardWillShow(notification: Notification) {
        if isKeyboardOpen{
            isKeyboardOpen = false
            
        } else {
            
        }
        guard let userInfo = notification.userInfo,
              let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        
        let otpTextFieldY = self.otpFirstDigitTF.frame.origin.x + self.otpFirstDigitTF.frame.origin.y + self.otpFirstDigitTF.frame.size.height
        print("mobileNumberTextFieldY :",otpTextFieldY)
        let visibleHeight = self.view.frame.size.height - keyboardSize.height
        //        print("Visible Height :",visibleHeight)
        
        if otpTextFieldY < visibleHeight {
            let yOffset = 0 - keyboardSize.height
                        print("Y Offset :",yOffset)
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
extension VerifyOTPViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = [otpFirstDigitTF, otpSecondDigitTF, otpThirdDigitTF, otpFourthDigitTF].first(where: { $0.isEditing }) {
            textField.textContentType = .oneTimeCode
            textField.textColor = UIColor.white
            textField.backgroundColor = UIColor(hex: "#389FFF")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        let borderColor = [otpFirstDigitTF.layer, otpSecondDigitTF.layer, otpThirdDigitTF.layer, otpFourthDigitTF.layer]
////        borderColor.forEach { $0.borderColor = UIColor.gray.cgColor }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Managing OTP textField Delegate (Checking Num value and Changing textField) -
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        
        if let digit = Int(string), newLength <= 1 {
            textField.text = String(digit)
            
            switch textField {
            case otpFirstDigitTF:
                otpSecondDigitTF.becomeFirstResponder()
            case otpSecondDigitTF:
                otpThirdDigitTF.becomeFirstResponder()
            case otpThirdDigitTF:
                otpFourthDigitTF.becomeFirstResponder()
            case otpFourthDigitTF:
                textField.resignFirstResponder()
            default:
                break
            }
            return false
        } else if string.isEmpty {
            // Handle backspace
            switch textField {
            case otpSecondDigitTF:
                otpFirstDigitTF.becomeFirstResponder()
            case otpThirdDigitTF:
                otpSecondDigitTF.becomeFirstResponder()
            case otpFourthDigitTF:
                otpThirdDigitTF.becomeFirstResponder()
            default:
                break
            }
            textField.text = ""
            return false
        }
        
        // Reject non-numeric characters
        return false
    }
}

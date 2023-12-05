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
    @IBOutlet weak var otpFourthDigitTF: UITextField!
    
    var verifyViewModel : VerifyNumberViewModel?
    private var deviceId : String?
    private var textFiledOtp: String?
    var receivedResponseOtp : Int?
    var mobileNumber: String?
    
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
            
        case .failure(let error):
            DispatchQueue.main.async {
                self.otpFirstDigitTF.roundCorners(5, borderWidth: 1, borderColor: UIColor.red)
                self.otpSecondDigitTF.roundCorners(5, borderWidth: 1, borderColor: UIColor.red)
                self.otpThirdDigitTF.roundCorners(5, borderWidth: 1, borderColor: UIColor.red)
                self.otpFourthDigitTF.roundCorners(5, borderWidth: 1, borderColor: UIColor.red)
            }
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
    }
    func getDeviceID() -> String {
        if let identifierForVendor = UIDevice.current.identifierForVendor {
            return identifierForVendor.uuidString
        } else {
            return "Unknown"
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

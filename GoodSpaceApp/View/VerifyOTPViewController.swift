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
            print("OTP verification Failed :",error)
        }
    }
    
    
    private func setupUI(){
        deviceId = getDeviceID()
        verifyViewModel = VerifyNumberViewModel()
        verifyViewModel?.delegate = self
    }
    func getDeviceID() -> String {
        if let identifierForVendor = UIDevice.current.identifierForVendor {
            return identifierForVendor.uuidString
        } else {
            return "Unknown"
        }
    }
    
}

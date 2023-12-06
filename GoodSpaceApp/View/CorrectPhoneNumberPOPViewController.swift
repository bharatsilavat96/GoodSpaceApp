//
//  CorrectPhoneNumberPOPViewController.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import UIKit

class CorrectPhoneNumberPOPViewController: UIViewController {

    
    @IBOutlet weak var corrctPhoneNumberTopLabel: UILabel!
    @IBOutlet weak var correctPhoneNumberTF: UITextField!
    @IBOutlet weak var correctPhoneNumberView: UIView!
    @IBOutlet weak var phoneNumberCountLabel: UILabel!
    @IBOutlet weak var verifyCorrectPhoneNumberButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func verifyPhoneNumberAction(_ sender: Any) {
        
        
    }
    private func setupUI(){
        verifyCorrectPhoneNumberButton.roundCorners(10, borderWidth: 0, borderColor: .clear)
        correctPhoneNumberView.roundCorners(10, borderWidth: 1, borderColor: UIColor(hex: "##C4C4C466"))
        correctPhoneNumberView.backgroundColor = UIColor(hex: "#FAFAFA")
    }
    
}
extension CorrectPhoneNumberPOPViewController: UITextFieldDelegate {
    
}

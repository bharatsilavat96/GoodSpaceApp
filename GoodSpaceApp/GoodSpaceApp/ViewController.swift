//
//  ViewController.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 04/12/23.
//

import UIKit

class ViewController: UIViewController{
    
    
    var deviceID : String?
    var deviceType: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        deviceID = getDeviceID()
    }
    
    
    
    
    func getDeviceID() -> String {
        if let identifierForVendor = UIDevice.current.identifierForVendor {
            print(identifierForVendor.uuidString)
            return identifierForVendor.uuidString
        } else {
            return "Unknown"
        }
    }

}
/*
 func authenticateUser() {
     
     guard let deviceID = deviceID, !deviceID.isEmpty else {
         print("Invalid deviceID")
         return
     }
     let authURL = URL(string: "https://api.ourgoodspace.com/api/d2/auth/v2/login")!
     var request = URLRequest(url: authURL)
     request.httpMethod = "POST"
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     request.addValue("\(deviceID)", forHTTPHeaderField: "device-id")
     request.addValue("web", forHTTPHeaderField: "device-type")

     let parameters: [String: Any] = [
         "number": "9340536820",
         "countryCode": "+91"
     ]

     do {
         request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
     } catch {
         print("Error encoding parameters: \(error.localizedDescription)")
         return
     }

     let task = URLSession.shared.dataTask(with: request) { data, response, error in
         guard error == nil else {
             print("Error during authentication request: \(error!.localizedDescription)")
             return
         }

         guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
             print("Invalid HTTP response")
             return
         }

         guard let data = data else {
             print("No data received")
             return
         }

         print("Authentication Response: \(String(data: data, encoding: .utf8) ?? "")")

         do {
             let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
             let otp = json?["otp"] as? String

             if let otp = otp {
                 self.verifyOTP(otp: otp)
             } else {
                 print("OTP not found in the response.")
             }
         } catch {
             print("Error decoding authentication response: \(error.localizedDescription)")
         }
     }

     task.resume()
 }

 func verifyOTP(otp: String) {
     let verifyURL = URL(string: "https://api.ourgoodspace.com/api/d2/auth/verifyotp")!
     var request = URLRequest(url: verifyURL)
     request.httpMethod = "POST"
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     request.addValue("Bearer your_access_token", forHTTPHeaderField: "Authorization")
     request.addValue("your_device_id", forHTTPHeaderField: "device-id")
     request.addValue("your_device_type", forHTTPHeaderField: "device-type")
     
     let parameters: [String: Any] = [
         "number": "+919340536820",
         "otp": otp
     ]
     
     do {
         request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
     } catch {
         print("Error encoding parameters: \(error.localizedDescription)")
         return
     }
     
     let task = URLSession.shared.dataTask(with: request) { data, response, error in
         guard let data = data, error == nil else {
             print("Error during OTP verification: \(error?.localizedDescription ?? "Unknown error")")
             return
         }
         
         do {
             let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
             let accessToken = json?["access_token"] as? String
             
             if let accessToken = accessToken {
                 print("Access Token: \(accessToken)")
                 // Now you can use the access token for further API requests
             } else {
                 print("Access token not found in the response.")
             }
         } catch {
             print("Error decoding OTP verification response: \(error.localizedDescription)")
         }
     }
     
     task.resume()
 }
 */

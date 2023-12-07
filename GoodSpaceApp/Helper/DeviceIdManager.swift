//
//  DeviceIdManager.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 07/12/23.
//

import Foundation
import UIKit

class DeviceIDManager {
    static func getDeviceID() -> String {
        if let identifierForVendor = UIDevice.current.identifierForVendor {
            return identifierForVendor.uuidString
        } else {
            // Fallback to a default value or handle the case when identifierForVendor is nil
            return "DefaultDeviceID"
        }
    }
}

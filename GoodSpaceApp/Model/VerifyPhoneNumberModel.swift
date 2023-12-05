//
//  VerifyPhoneNumber.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import Foundation

struct verifyPhoneNumberModel: Codable {
    let message: String?
    let data: VerifyDataModel?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.message, forKey: .message)
        try container.encodeIfPresent(self.data, forKey: .data)
    }
    
    enum CodingKeys: CodingKey {
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent(VerifyDataModel.self, forKey: .data)
    }
}

struct VerifyDataModel: Codable {
    
    let userId: Int32?
    let countryCode: String?
    let imageId: String?
    let name: String?
    let emailId: String?
    let status: Int?
    let accountTypeId: Int?
    let purchaseValidity: String?
    let inviteLink1: String?
    let token: String?
    let mobileNumber: String?
    let isPremium: Int?
    let inviteLink: String?
    let isHiringSelected: Bool?
    let atLeastHiringSelected: Bool?
    let userMode: String?
    let needToDoOnboarding: Bool?
    let previousUserMode: PreviousModel?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.countryCode, forKey: .countryCode)
        try container.encodeIfPresent(self.imageId, forKey: .imageId)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.emailId, forKey: .emailId)
        try container.encodeIfPresent(self.status, forKey: .status)
        try container.encodeIfPresent(self.accountTypeId, forKey: .accountTypeId)
        try container.encodeIfPresent(self.purchaseValidity, forKey: .purchaseValidity)
        try container.encodeIfPresent(self.inviteLink1, forKey: .inviteLink1)
        try container.encodeIfPresent(self.token, forKey: .token)
        try container.encodeIfPresent(self.mobileNumber, forKey: .mobileNumber)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.inviteLink, forKey: .inviteLink)
        try container.encodeIfPresent(self.isHiringSelected, forKey: .isHiringSelected)
        try container.encodeIfPresent(self.atLeastHiringSelected, forKey: .atLeastHiringSelected)
        try container.encodeIfPresent(self.userMode, forKey: .userMode)
        try container.encodeIfPresent(self.needToDoOnboarding, forKey: .needToDoOnboarding)
        try container.encodeIfPresent(self.previousUserMode, forKey: .previousUserMode)
    }
    
    enum CodingKeys: String, CodingKey {
        
        case userId  = "user_id"
        case countryCode = "country_code"
        case imageId = "image_id"
        case name
        case emailId = "email_id"
        case status
        case accountTypeId = "account_type_id"
        case purchaseValidity = "purchase_validity"
        case inviteLink1 = "invite_link"
        case token
        case mobileNumber = "mobile_number"
        case isPremium = "is_premium"
        case inviteLink
        case isHiringSelected
        case atLeastHiringSelected
        case userMode
        case needToDoOnboarding
        case previousUserMode
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decodeIfPresent(Int32.self, forKey: .userId)
        self.countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
        self.imageId = try container.decodeIfPresent(String.self, forKey: .imageId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.emailId = try container.decodeIfPresent(String.self, forKey: .emailId)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.accountTypeId = try container.decodeIfPresent(Int.self, forKey: .accountTypeId)
        self.purchaseValidity = try container.decodeIfPresent(String.self, forKey: .purchaseValidity)
        self.inviteLink1 = try container.decodeIfPresent(String.self, forKey: .inviteLink1)
        self.token = try container.decodeIfPresent(String.self, forKey: .token)
        self.mobileNumber = try container.decodeIfPresent(String.self, forKey: .mobileNumber)
        self.isPremium = try container.decodeIfPresent(Int.self, forKey: .isPremium)
        self.inviteLink = try container.decodeIfPresent(String.self, forKey: .inviteLink)
        self.isHiringSelected = try container.decodeIfPresent(Bool.self, forKey: .isHiringSelected)
        self.atLeastHiringSelected = try container.decodeIfPresent(Bool.self, forKey: .atLeastHiringSelected)
        self.userMode = try container.decodeIfPresent(String.self, forKey: .userMode)
        self.needToDoOnboarding = try container.decodeIfPresent(Bool.self, forKey: .needToDoOnboarding)
        self.previousUserMode = try container.decodeIfPresent(PreviousModel.self, forKey: .previousUserMode)
    }
    
}
struct PreviousModel: Codable {
    let mode: String?
    let createdAt: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.mode, forKey: .mode)
        try container.encodeIfPresent(self.createdAt, forKey: .createdAt)
    }
    
    enum CodingKeys: String, CodingKey {
        case mode
        case createdAt = "created_at"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mode = try container.decodeIfPresent(String.self, forKey: .mode)
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
    }
    
}

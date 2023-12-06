//
//  JobsModel.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 06/12/23.
//

import Foundation

struct Datum: Codable {
    let type: String?
    let cardData: CardData?
    let cardType, cardVariant: String?
}

// MARK: - CardData
struct CardData: Codable {
    let showOrganisation, offerID, userID: Int
    let companyName: String
    let offerTypeID: Int
    let description: String
    let url: String
    let lowerworkex, upperworkex: Int
    let monthlyCompensation, hourlyCompensation: String?
    let monthlyCompensationID, hourlyCompensationID: Int?
    let isRemote: Int
    let redirectURL, minScore, minAge, maxAge: JSONNull?
    let locationCity: String?
    let distance: Double?
    let isOrganic: Int
    let title: String
    let industryTypeID, industryType: JSONNull?
    let jobFunctionID, designationID: Int
    let designation, date: String
    let hasApplied, needToRedirect, jobSaved, isBusinessOpportunity: Bool
    let showRelocateModal: Bool
    let skills: [Skill]
    let jobType: [JobType]
    let displayCompensation, relativeTime, postedAtRelative: String
    let hasLiked: Bool
    let userInfo: UserInfo

    enum CodingKeys: String, CodingKey {
        case showOrganisation
        case offerID
        case userID
        case companyName
        case offerTypeID
        case description, url, lowerworkex, upperworkex
        case monthlyCompensation
        case hourlyCompensation
        case monthlyCompensationID
        case hourlyCompensationID
        case isRemote
        case redirectURL
        case minScore, minAge, maxAge
        case locationCity
        case distance
        case isOrganic
        case title
        case industryTypeID
        case industryType
        case jobFunctionID
        case designationID
        case designation, date, hasApplied, needToRedirect, jobSaved, isBusinessOpportunity, showRelocateModal, skills, jobType, displayCompensation, relativeTime, postedAtRelative, hasLiked, userInfo
    }
}

// MARK: - JobType
struct JobType: Codable {
    let offerID, jobTypeID: Int
    let jobType: String

    enum CodingKeys: String, CodingKey {
        case offerID
        case jobTypeID
        case jobType
    }
}

// MARK: - Skill
struct Skill: Codable {
    let offerID, skillID: Int
    let skill: String

    enum CodingKeys: String, CodingKey {
        case offerID
        case skillID
        case skill
    }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let userID: Int
    let name: String
    let imageID: String
    let score: Double
    let isProfileVerified: Bool

    enum CodingKeys: String, CodingKey {
        case userID
        case name
        case imageID
        case score, isProfileVerified
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

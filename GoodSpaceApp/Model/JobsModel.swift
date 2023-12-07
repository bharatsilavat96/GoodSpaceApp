//
//  JobsModel.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 06/12/23.
//

import Foundation

struct JobModel: Codable {
    let type: String?
    let cardData: CardData?
    let cardType, cardVariant: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.cardData, forKey: .cardData)
        try container.encodeIfPresent(self.cardType, forKey: .cardType)
        try container.encodeIfPresent(self.cardVariant, forKey: .cardVariant)
    }
    enum CodingKeys: CodingKey {
        case type
        case cardData
        case cardType
        case cardVariant
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.cardData = try container.decodeIfPresent(CardData.self, forKey: .cardData)
        self.cardType = try container.decodeIfPresent(String.self, forKey: .cardType)
        self.cardVariant = try container.decodeIfPresent(String.self, forKey: .cardVariant)
    }
}

// MARK: - CardData
struct CardData: Codable {
    
    let showOrganisation: Int?
    let offerId: Int?
    let userId: Int?
    let companyName: String?
    let offerTypeId: Int?
    let description: String?
    let url: String?
    let lowerworkex: Int?
    let upperworkex: Int?
    let monthlyCompensation: String?
    let hourlyCompensation: String?
    let monthlyCompensationId: Int?
    let hourlyCompensationId: Int?
    let isRemote: Int?
    let redirectUrl: String?
    let minScore: String?
    let minAge: Int?
    let maxAge: Int?
    let locationCity: String?
    let distance: Double?
    let isOrganic: Int?
    let title: String?
    let industryTypeId: String?
    let industryType: String?
    let jobFunctionId: Int?
    let designationId: Int?
    let designation: String?
    let date: String?
    let hasApplied: Bool?
    let needToRedirect: Bool?
    let jobSaved: Bool?
    let isBusinessOpportunity: Bool?
    let showRelocateModal: Bool?
    let skills: [Skill]?
    let jobType: [JobType]?
    let displayCompensation: String?
    let relativeTime: String?
    let postedAtRelative: String?
    let hasLiked: Bool?
    let userInfo: UserInfo?

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.showOrganisation, forKey: .showOrganisation)
        try container.encodeIfPresent(self.offerId, forKey: .offerId)
        try container.encodeIfPresent(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.companyName, forKey: .companyName)
        try container.encodeIfPresent(self.offerTypeId, forKey: .offerTypeId)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.lowerworkex, forKey: .lowerworkex)
        try container.encodeIfPresent(self.upperworkex, forKey: .upperworkex)
        try container.encodeIfPresent(self.monthlyCompensation, forKey: .monthlyCompensation)
        try container.encodeIfPresent(self.hourlyCompensation, forKey: .hourlyCompensation)
        try container.encodeIfPresent(self.monthlyCompensationId, forKey: .monthlyCompensationId)
        try container.encodeIfPresent(self.hourlyCompensationId, forKey: .hourlyCompensationId)
        try container.encodeIfPresent(self.isRemote, forKey: .isRemote)
        try container.encodeIfPresent(self.redirectUrl, forKey: .redirectUrl)
        try container.encodeIfPresent(self.minScore, forKey: .minScore)
        try container.encodeIfPresent(self.minAge, forKey: .minAge)
        try container.encodeIfPresent(self.maxAge, forKey: .maxAge)
        try container.encodeIfPresent(self.locationCity, forKey: .locationCity)
        try container.encodeIfPresent(self.distance, forKey: .distance)
        try container.encodeIfPresent(self.isOrganic, forKey: .isOrganic)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.industryTypeId, forKey: .industryTypeId)
        try container.encodeIfPresent(self.industryType, forKey: .industryType)
        try container.encodeIfPresent(self.jobFunctionId, forKey: .jobFunctionId)
        try container.encodeIfPresent(self.designationId, forKey: .designationId)
        try container.encodeIfPresent(self.designation, forKey: .designation)
        try container.encodeIfPresent(self.date, forKey: .date)
        try container.encodeIfPresent(self.hasApplied, forKey: .hasApplied)
        try container.encodeIfPresent(self.needToRedirect, forKey: .needToRedirect)
        try container.encodeIfPresent(self.jobSaved, forKey: .jobSaved)
        try container.encodeIfPresent(self.isBusinessOpportunity, forKey: .isBusinessOpportunity)
        try container.encodeIfPresent(self.showRelocateModal, forKey: .showRelocateModal)
        try container.encodeIfPresent(self.skills, forKey: .skills)
        try container.encodeIfPresent(self.jobType, forKey: .jobType)
        try container.encodeIfPresent(self.displayCompensation, forKey: .displayCompensation)
        try container.encodeIfPresent(self.relativeTime, forKey: .relativeTime)
        try container.encodeIfPresent(self.postedAtRelative, forKey: .postedAtRelative)
        try container.encodeIfPresent(self.hasLiked, forKey: .hasLiked)
        try container.encodeIfPresent(self.userInfo, forKey: .userInfo)
    }
    
    enum CodingKeys: String, CodingKey {
        case showOrganisation
        case offerId
        case userId
        case companyName
        case offerTypeId
        case description
        case url
        case lowerworkex
        case upperworkex
        case monthlyCompensation = "monthly_compensation"
        case hourlyCompensation = "hourly_compensation"
        case monthlyCompensationId = "monthly_compensation_id"
        case hourlyCompensationId = "hourly_compensation_id"
        case isRemote = "is_Remote"
        case redirectUrl
        case minScore
        case minAge
        case maxAge
        case locationCity = "location_city"
        case distance
        case isOrganic = "is_organic"
        case title
        case industryTypeId = "industry_type_id"
        case industryType = "industry_type"
        case jobFunctionId = "job_function_id"
        case designationId = "designation_id"
        case designation
        case date
        case hasApplied
        case needToRedirect
        case jobSaved
        case isBusinessOpportunity
        case showRelocateModal
        case skills
        case jobType
        case displayCompensation
        case relativeTime
        case postedAtRelative
        case hasLiked
        case userInfo
    }
}

// MARK: - JobType
struct JobType: Codable {
    let offerID: Int?
    let jobTypeId: Int?
    let jobType: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.offerID, forKey: .offerID)
        try container.encodeIfPresent(self.jobTypeId, forKey: .jobTypeId)
        try container.encodeIfPresent(self.jobType, forKey: .jobType)
    }
    
    enum CodingKeys: String, CodingKey {
        case offerID
        case jobTypeId = "job_type_id"
        case jobType = "job_type"
    }
    
}

// MARK: - Skill
struct Skill: Codable {
    let offerID: Int?
    let skillId: Int?
    let skill: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.offerID, forKey: .offerID)
        try container.encodeIfPresent(self.skillId, forKey: .skillId)
        try container.encodeIfPresent(self.skill, forKey: .skill)
    }
    
    enum CodingKeys: String,CodingKey {
        case offerID
        case skillId = "skill_id"
        case skill
    }

}

// MARK: - UserInfo
struct UserInfo: Codable {
    let userId: Int?
    let name: String?
    let imageId: String?
    let score: Double?
    let isProfileVerified: Bool?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.imageId, forKey: .imageId)
        try container.encodeIfPresent(self.score, forKey: .score)
        try container.encodeIfPresent(self.isProfileVerified, forKey: .isProfileVerified)
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case imageId = "image_id"
        case score
        case isProfileVerified
    }
}


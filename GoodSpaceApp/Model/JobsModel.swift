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
//    let hourlyCompensation: Any
    let monthlyCompensationId: Int?
//    let hourlyCompensationId: Any
    let isRemote: Int?
//    let redirectUrl: Any
//    let minScore: Any
//    let minAge: Any
//    let maxAge: Any
    let locationCity: String?
    let distance: Double?
    let isOrganic: Int?
    let title: String?
//    let industryTypeId: Any
//    let industryType: Any
    let jobFunctionId: Int?
    let designationId: Int?
    let designation: String?
    let date: String?
    let hasApplied: Bool?
//    let needToRedirect: Any
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
//        case hourlyCompensation = "hourly_compensation"
        case monthlyCompensationId = "monthly_compensation_id"
//        case hourlyCompensationId = "hourly_compensation_id"
        case isRemote = "is_Remote"
//        case redirectUrl
//        case minScore
//        case minAge
//        case maxAge
        case locationCity = "location_city"
        case distance
        case isOrganic = "is_organic"
        case title
//        case industryTypeId = "industry_type_id"
//        case industryType = "industry_type"
        case jobFunctionId = "job_function_id"
        case designationId = "designation_id"
        case designation
        case date
        case hasApplied
//        case needToRedirect
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
    init(showOrganisation: Int?, offerId: Int?, userId: Int?, companyName: String?, offerTypeId: Int?, description: String?, url: String?, lowerworkex: Int?, upperworkex: Int?, monthlyCompensation: String?, hourlyCompensation: Any, monthlyCompensationId: Int?, hourlyCompensationId: Any, isRemote: Int?, redirectUrl: Any, minScore: Any, minAge: Any, maxAge: Any, locationCity: String?, distance: Double?, isOrganic: Int?, title: String?, industryTypeId: Any, industryType: Any, jobFunctionId: Int?, designationId: Int?, designation: String?, date: String?, hasApplied: Bool?, needToRedirect: Any, jobSaved: Bool?, isBusinessOpportunity: Bool?, showRelocateModal: Bool?, skills: [Skill]?, jobType: [JobType]?, displayCompensation: String?, relativeTime: String?, postedAtRelative: String?, hasLiked: Bool?, userInfo: UserInfo?) {
        self.showOrganisation = showOrganisation
        self.offerId = offerId
        self.userId = userId
        self.companyName = companyName
        self.offerTypeId = offerTypeId
        self.description = description
        self.url = url
        self.lowerworkex = lowerworkex
        self.upperworkex = upperworkex
        self.monthlyCompensation = monthlyCompensation
//        self.hourlyCompensation = hourlyCompensation
        self.monthlyCompensationId = monthlyCompensationId
//        self.hourlyCompensationId = hourlyCompensationId
        self.isRemote = isRemote
//        self.redirectUrl = redirectUrl
//        self.minScore = minScore
//        self.minAge = minAge
//        self.maxAge = maxAge
        self.locationCity = locationCity
        self.distance = distance
        self.isOrganic = isOrganic
        self.title = title
//        self.industryTypeId = industryTypeId
//        self.industryType = industryType
        self.jobFunctionId = jobFunctionId
        self.designationId = designationId
        self.designation = designation
        self.date = date
        self.hasApplied = hasApplied
//        self.needToRedirect = needToRedirect
        self.jobSaved = jobSaved
        self.isBusinessOpportunity = isBusinessOpportunity
        self.showRelocateModal = showRelocateModal
        self.skills = skills
        self.jobType = jobType
        self.displayCompensation = displayCompensation
        self.relativeTime = relativeTime
        self.postedAtRelative = postedAtRelative
        self.hasLiked = hasLiked
        self.userInfo = userInfo
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
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.offerID = try container.decodeIfPresent(Int.self, forKey: .offerID)
        self.jobTypeId = try container.decodeIfPresent(Int.self, forKey: .jobTypeId)
        self.jobType = try container.decodeIfPresent(String.self, forKey: .jobType)
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
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.offerID = try container.decodeIfPresent(Int.self, forKey: .offerID)
        self.skillId = try container.decodeIfPresent(Int.self, forKey: .skillId)
        self.skill = try container.decodeIfPresent(String.self, forKey: .skill)
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
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decodeIfPresent(Int.self, forKey: .userId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.imageId = try container.decodeIfPresent(String.self, forKey: .imageId)
        self.score = try container.decodeIfPresent(Double.self, forKey: .score)
        self.isProfileVerified = try container.decodeIfPresent(Bool.self, forKey: .isProfileVerified)
    }
}


//
//  JobsModel.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 06/12/23.
//

import Foundation

// MARK: - Response
struct ApiResponse: Codable {
    let data: [Job]?
    let status: Int?
    
}

// MARK: - Job
struct Job: Codable {
    let type: String?
    let cardData: CardData?
}

// MARK: - CardData
struct CardData: Codable {
    let showOrganisation, offerId, userId: Int?
    let companyName: String?
    let offerTypeId: Int?
    let description, url: String?
    let lowerWorkex, upperWorkex: Int?
    let monthlyCompensation, hourlyCompensation: String?
    let monthlyCompensationID, hourlyCompensationID: Int?
    let isRemote: Int?
    let redirectUrl: String?
    let minScore, minAge, maxAge: Int?
    let locationCity: String?
    let distance: Double?
    let isOrganic: Int?
    let title: String?
    let industryTypeID: Int?
    let industryType: String?
        let jobFunctionID: Int?
    let designationID: Int?
    let designation: String?
    let date: String?
    let hasApplied, needToRedirect, jobSaved, isBusinessOpportunity: Bool
    let showRelocateModal: Bool
    let skills: [Skill]
    let jobType: [JobType]
    let displayCompensation, relativeTime, postedAtRelative: String?
    let hasLiked: Bool
    let userInfo: UserInfo
    
    enum CodingKeys: String, CodingKey {
        case showOrganisation
        case offerId
        case userId
        case companyName
        case offerTypeId
        case description
        case url
        case lowerWorkex = "lowerworkex"
        case upperWorkex = "upperworkex"
        case monthlyCompensation = "monthly_compensation"
        case hourlyCompensation = "hourly_compensation"
        case monthlyCompensationID = "monthly_compensation_id"
        case hourlyCompensationID = "hourly_compensation_id"
        case isRemote = "is_remote"
        case redirectUrl
        case minScore
        case minAge
        case maxAge
        case locationCity = "location_city"
        case distance
        case isOrganic = "is_organic"
        case title
        case industryTypeID = "industry_type_id" // null
        case industryType = "industry_type" //null
        case jobFunctionID = "job_function_id"
        case designationID = "designation_id"
        case designation = "designation"
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
    let offerId, jobTypeID: Int?
    let jobType: String?
    
    enum CodingKeys: String, CodingKey {
        case offerId
        case jobTypeID = "job_type_id"
        case jobType = "job_type"
    }
}

// MARK: - Skill
struct Skill: Codable {
    let offerId, skillID: Int?
    let skill: String?
    
    enum CodingKeys: String, CodingKey {
        case offerId
        case skillID = "skill_id"
        case skill
    }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let userID: Int?
    let name, imageID: String?
    let score: Double?
    let isProfileVerified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name = "name"
        case imageID = "image_id"
        case score = "score"
        case isProfileVerified = "isProfileVerified"
    }

}


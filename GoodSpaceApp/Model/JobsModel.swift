//
//  JobsModel.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 06/12/23.
//

import Foundation

struct JobsModel: Codable{
    
    let data: [JobsData]?
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.data, forKey: .data)
    }
    enum CodingKeys: CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent([JobsData].self, forKey: .data)
    }
    
}
struct JobsData: Codable{
    let type: String?
    let cardData: [CardData]?
    let status: Int?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.cardData, forKey: .cardData)
        try container.encodeIfPresent(self.status, forKey: .status)
    }
    enum CodingKeys: CodingKey {
        case type
        case cardData
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.cardData = try container.decodeIfPresent([CardData].self, forKey: .cardData)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
    }
}
struct CardData: Codable{
    let companyName: String?
    let url: String?
    let monthlyCompensation:String?
    let locationCity : String?
    let title: String?
    let designation : String?
    let hasApplied: Bool?
    let jobSaved: Bool?
    let date: String?
    let jobType : [JobType]?
    let displayCompensation : String?
    let postedAtRelative: String
    let hasLiked: Bool?
    let userInfo: UserInfo?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.companyName, forKey: .companyName)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.monthlyCompensation, forKey: .monthlyCompensation)
        try container.encodeIfPresent(self.locationCity, forKey: .locationCity)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.designation, forKey: .designation)
        try container.encodeIfPresent(self.hasApplied, forKey: .hasApplied)
        try container.encodeIfPresent(self.jobSaved, forKey: .jobSaved)
        try container.encodeIfPresent(self.date, forKey: .date)
        try container.encodeIfPresent(self.jobType, forKey: .jobType)
        try container.encodeIfPresent(self.displayCompensation, forKey: .displayCompensation)
        try container.encode(self.postedAtRelative, forKey: .postedAtRelative)
        try container.encodeIfPresent(self.hasLiked, forKey: .hasLiked)
        try container.encodeIfPresent(self.userInfo, forKey: .userInfo)
    }
    enum CodingKeys: String,CodingKey {
        case companyName
        case url
        case monthlyCompensation = "monthly_compensation"
        case locationCity = "location_city"
        case title
        case designation
        case hasApplied
        case jobSaved
        case date
        case jobType
        case displayCompensation
        case postedAtRelative
        case hasLiked
        case userInfo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.companyName = try container.decodeIfPresent(String.self, forKey: .companyName)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.monthlyCompensation = try container.decodeIfPresent(String.self, forKey: .monthlyCompensation)
        self.locationCity = try container.decodeIfPresent(String.self, forKey: .locationCity)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.designation = try container.decodeIfPresent(String.self, forKey: .designation)
        self.hasApplied = try container.decodeIfPresent(Bool.self, forKey: .hasApplied)
        self.jobSaved = try container.decodeIfPresent(Bool.self, forKey: .jobSaved)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.jobType = try container.decodeIfPresent([JobType].self, forKey: .jobType)
        self.displayCompensation = try container.decodeIfPresent(String.self, forKey: .displayCompensation)
        self.postedAtRelative = try container.decode(String.self, forKey: .postedAtRelative)
        self.hasLiked = try container.decodeIfPresent(Bool.self, forKey: .hasLiked)
        self.userInfo = try container.decodeIfPresent(UserInfo.self, forKey: .userInfo)
    }
}
struct JobType: Codable {
    let JobType: String?
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.JobType, forKey: .JobType)
    }
    
    enum CodingKeys: String,CodingKey {
        case JobType = "job_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.JobType = try container.decodeIfPresent(String.self, forKey: .JobType)
    }
}
struct UserInfo: Codable {
    let name: String?
    let imageID:String?
    let isProfileVerified: Bool?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.imageID, forKey: .imageID)
        try container.encodeIfPresent(self.isProfileVerified, forKey: .isProfileVerified)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageID = "image_id"
        case isProfileVerified
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.imageID = try container.decodeIfPresent(String.self, forKey: .imageID)
        self.isProfileVerified = try container.decodeIfPresent(Bool.self, forKey: .isProfileVerified)
    }
}

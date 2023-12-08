//
//  InActiveProductModel.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 08/12/23.
//

import Foundation

struct InActiveProductModel: Codable{
    let data: [ProductData]?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.data, forKey: .data)
    }
}

struct ProductData: Codable{
    
    let displayName: String?
    let productName: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.displayName, forKey: .displayName)
        try container.encodeIfPresent(self.productName, forKey: .productName)
    }
}

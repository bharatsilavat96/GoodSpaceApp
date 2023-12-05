//
//  LoginModel.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import Foundation

struct LoginModel: Codable{
    
    var message: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.message, forKey: .message)
    }
    enum CodingKeys: CodingKey {
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }

}

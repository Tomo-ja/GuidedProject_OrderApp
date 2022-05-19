//
//  ResponseModels.swift
//  GuidedProject_OrderApp
//
//  Created by Tomonao Hashiguchi on 2022-05-19.
//

import Foundation

struct MenuResponse: Codable{
    let items: [MenuItem]
}

struct CategoriesResponse: Codable{
    let categories: [String]
}

struct OrderResponse: Codable{
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey{
        case prepTime = "preparation_time"
    }
}

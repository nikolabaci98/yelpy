//
//  Restaurant.swift
//  CPlab1
//
//  Created by Nikola Baci on 2/22/22.
//

import Foundation

struct Restaurant: Decodable {
    let name: String?
    let category: String?
    let rating: Float?
    let display_phone: String?
    let image_url: String?
}

struct Business: Decodable {
    let name: String?
    let categories: [[String:String]]?
    let rating: Float?
    let display_phone: String?
    let image_url: String?
}

struct RestaurantsList: Decodable {
    var businesses = [Business]()
}



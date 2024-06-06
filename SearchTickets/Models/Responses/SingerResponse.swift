//
//  SingerResponse.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 06.06.2024.
//

import Foundation

struct Singer: Codable {
    let id: Int
    let title: String
    let town: String
    let price: Price
}

struct Price: Codable {
    let value: Int
}

struct OffersResponse: Codable {
    let singers: [Singer]
}


//
//  SearchResponse.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 06.06.2024.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let ticketsOffers: [TicketsOffer]

    enum CodingKeys: String, CodingKey {
        case ticketsOffers = "tickets_offers"
    }
}

// MARK: - TicketsOffer
struct TicketsOffer: Codable {
    let id: Int
    let title: String
    let timeRange: [String]
    let price: Price

    enum CodingKeys: String, CodingKey {
        case id, title
        case timeRange = "time_range"
        case price
    }
}


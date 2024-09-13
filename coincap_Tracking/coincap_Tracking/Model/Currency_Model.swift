//
//  Currency.swift
//  coincap_Tracking
//
//  Created by ms k on 8/27/24.
//

import Foundation

struct CurrencyStore : Codable{
    var data : [Currency]
    var timestamp : Int
}

struct CurrencyQuery : Codable{
    var data : Currency
}

struct Currency : Hashable, Codable, Identifiable{
    var id : String
    var symbol : String
    var currencySymbol : String?
    var type : String
    var rateUsd : Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case currencySymbol
        case type
        case rateUsd
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        symbol = try container.decode(String.self, forKey: .symbol)
        currencySymbol = try container.decode(String?.self, forKey: .currencySymbol)
        type = try container.decode(String.self, forKey: .type)
        let rateUsdStr = try container.decode(String.self, forKey: .rateUsd)
        rateUsd = Double(rateUsdStr) ?? 0.0
        
    }
}

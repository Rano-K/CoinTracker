//
//  Coin_Model.swift
//  coincap_Tracking
//
//  Created by ms k on 8/20/24.
//

import Foundation
//모든 정보 담아올 곳
struct CoinStore : Codable{
    var data : [Coin]
    var timestamp : Int
}
//특정정보 담길 곳
struct CoinQuery : Codable{
    var data : Coin
}


struct Coin : Hashable, Codable, Identifiable{
    var id: String
    var rank : String
    var symbol : String
    var name : String
    var supply : Double
    var maxSupply : Double?
    var marketCap : Double
    var volume : Double
    var price : Double
    var changePercent : Double
//    var explorer : String?
    
    enum CodingKeys : String, CodingKey{
        case id
        case rank
        case symbol
        case name
        case supply
        case maxSupply
        case marketCap = "marketCapUsd"
        case volume = "volumeUsd24Hr"
        case price = "priceUsd"
        case changePercent = "changePercent24Hr"
//        case explorer
    }
//    "data": [
//    {
//      "id": "bitcoin",                                String
//      "rank": "1",                                    Int
//      "symbol": "BTC",                                String
//      "name": "Bitcoin",                              String
//      "supply": "17193925.0000000000000000",          Double
//      "maxSupply": "21000000.0000000000000000",       Double
//      "marketCapUsd": "119150835874.4699281625807300",Double
//      "volumeUsd24Hr": "2927959461.1750323310959460", Double
//      "priceUsd": "6929.8217756835584756",            Double
//      "changePercent24Hr": "-0.8101417214350335",     Double
//      "vwap24Hr": "7175.0663247679233209"             Double
//    },
//    
    init(from decoder: any Decoder) throws {
        
        //container는 JSON으로 부터 받아온 데이터를 저장할 곳 -> SwiftData에 mapping해야됨.
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //container로 부터 Decoding해올 것
        
        //기본적인 String값
        self.id = try container.decode(String.self, forKey: .id)
        self.rank = try container.decode(String.self, forKey: .rank)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        
        //String을 Double값으로 변경
        let supplyStr = try container.decode(String.self, forKey: .supply)
        self.supply = Double(supplyStr) ?? 0.0
        
        let maxSupplyStr = try container.decodeIfPresent(String.self, forKey: .maxSupply)
        self.maxSupply = Double(maxSupplyStr ?? "0.0")
        
        let marketCapStr = try container.decode(String.self, forKey: .marketCap)
        self.marketCap = Double(marketCapStr) ?? 0.0
        
        let volumeStr = try container.decode(String.self, forKey: .volume)
        self.volume = Double(volumeStr) ?? 0.0
        
        let priceStr = try container.decode(String.self, forKey: .price)
        self.price = Double(priceStr) ?? 0.0
        
        let changePercentStr = try container.decode(String.self, forKey: .changePercent)
        self.changePercent = Double(changePercentStr) ?? 0.0
        
//        self.explorer = try container.decode(String.self, forKey: .explorer)
    }
}

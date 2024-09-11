//
//  CoinRestfulService_assets.swift
//  coincap_Tracking
//
//  Created by ms k on 9/11/24.
//

import Foundation

class CoinRestfulService_assets {
    private let coinStoreUrl = "https://api.coincap.io/v2/assets/"
    
    func quoteAllCoins(limit: Int = 0) async -> [Coin]? {
        
        var queryUrl = coinStoreUrl
        
        if limit > 0 {
            queryUrl += "?limit=\(limit)"
        }
        
        guard let url = URL(string: queryUrl) else {
            return nil
        }
        
        var coin: [Coin]? = nil
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let coinContainer = try JSONDecoder().decode(CoinStore.self, from: data)
            coin = coinContainer.data
            
        } catch {
            print(error)
        }
        
        return coin
    }
    
    func quote(_ coinId: String) async -> Coin? {
        
        guard let url = URL(string: coinStoreUrl + coinId) else {
            return nil
        }
        
        var coin: Coin? = nil
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let coinContainer = try JSONDecoder().decode(CoinQuery.self, from: data)
            coin = coinContainer.data
            
        } catch {
            print(error)
        }
        
        return coin
    }
}

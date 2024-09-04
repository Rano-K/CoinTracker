//
//  CoinRestfulService_assets.swift
//  coincap_Tracking
//
//  Created by ms k on 8/30/24.
//

import SwiftUI

class CoinRestfulService_assets{
    //api주소
    private let  coinStoreUrl = "https://api.coincap.io/v2/assets/"
    
    //모든 코인정보 가져오기
    func quoteAllCoins(limit: Int = 0) async -> [Coin]? {
        
        var queryUrl = coinStoreUrl
        
        if limit > 0 {
            queryUrl += "?limit=\(limit)"
        }
        
        guard let url = URL(string: queryUrl) else{
            return nil
        }
        
        var coin : [Coin]? = nil
        
        do{
            //URL로부터 data를 받아오기 전까지 기다린다.
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //coin정보 담아서 해독할 곳.
            let coinContainer = try JSONDecoder().decode(CoinStore.self, from: data)
            coin = coinContainer.data
            
        } catch{
            print(error)
        }
        
        return coin
    }
    
    func quoto(_ coinId : String) async -> Coin? {
        
        guard let url = URL(string: coinStoreUrl + coinId) else{
            return nil
        }
        
        var coin : Coin? = nil
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let coinCointainer = try JSONDecoder().decode(CoinQuery.self, from: data)
            coin = coinCointainer.data
            
        }catch{
            print(error)
        }
        
        return coin
        
    }
}

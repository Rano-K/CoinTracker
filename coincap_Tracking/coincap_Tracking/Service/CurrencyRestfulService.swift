//
//  CurrencyRestAPI.swift
//  coincap_Tracking
//
//  Created by ms k on 9/13/24.
//

import Foundation

class CurrencyRestfulService {
    private let currencyUrl = "https://api.coincap.io/v2/rates/"
    
    func quoteAllRates() async -> [Currency]? {
        
        let queryUrl = currencyUrl
        
        guard let url = URL(string: queryUrl) else{
            return nil
        }
        
        var currency : [Currency]? = nil
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let currencyContainer = try JSONDecoder().decode(CurrencyStore.self, from: data)
            currency = currencyContainer.data

        }catch{
            print(error)
        }
        
        
        return currency
    }
    
    func quote_KRW(_ currencyId: String) async -> Currency?{
        
        guard let url = URL(string :currencyUrl + currencyId) else { return nil
        }
        
        var currency : Currency? = nil
        do{
            let(data, _) = try await URLSession.shared.data(from: url)
            
            let currencyContainer = try JSONDecoder().decode(CurrencyQuery.self, from: data)
            currency = currencyContainer.data
            
            
        }catch{
            print(error)
        }
        
        return currency
    }
    
}

////
////  CoinWebSocketService_trads.swift
////  coincap_Tracking
////
////  Created by ms k on 9/9/24.
////
////TEST CODE 이걸로 tradeCoin을 받아올 수 있을까?
//
//import Foundation
//
////Trade endpoint를 담을 구조체
//struct CoinTrade {
//    var exchange : String
//    var base : String
//    var quote : String
//    var direction : String
//    var price : Double
//    var volume : Double
//    var timestamp : Int64
//    var priceUsd : Double
//}
//
//
//@Observable
//class Trades_CoinWebSocketService{
//    private let coinPriceURL = "wss://ws.coincap.io/trades/binance"
//    private var session = URLSession(configuration: .default)
//    private var webSocketTask : URLSessionWebSocketTask? = nil
//    
//    var tradedCoins : [[String : Any]]?
//    
//    //connect Start
//    func connect() async {
//        
//        guard let url = URL(string: coinPriceURL)else{
//             return
//        }
//        
//        webSocketTask = URLSession.shared.webSocketTask(with: url)
//        webSocketTask?.resume()
//        
//    }//connect End
//    
//    //receive Start
//    private func receive() async throws {
//        let response = try await webSocketTask?.receive()
//        
//        tradedCoins = [[:]]
//        
//        switch response{
//        case .string(let text) :
//            print("Received TradeCoins : \(text)")
//            
//            if let data = text.data(using: .utf8),
//               let coinPair = try JSONSerialization.jsonObject(with: data) as? [String : Any]{
//                
//                coinPair.forEach{ (key, value) in
//                    //value가 Double일 때, String일 때 분리해야한다.
//                    if let tradedCoinDouble = value as? Double{
//                        tradedCoins?.append([key : tradedCoinDouble])
//                    }else if let tradedCoinString = value as? String{
//                        tradedCoins?.append([key : tradedCoinString])
//                    }else{
//                        print("unsupported type key : \(key)")
//                    }
//                }
//            }
//        case .data(let data):
//            print("Received TradeCoins : \(data)")
//        default:
//            break
//        }
//        
//        try await receive()
//    }//receive END
//    
//    
//    private func disconnect(){
//        webSocketTask?.cancel(with: .goingAway, reason: .none)
//        webSocketTask = nil
//    }
//    
//    private func reconnect() async {
//        disconnect()
//        await connect()
//    }
//    
//    
//
//}

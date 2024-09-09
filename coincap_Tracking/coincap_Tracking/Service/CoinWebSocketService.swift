//
//  CoinWebSocketService.swift
//  coincap_Tracking
//
//  Created by ms k on 9/4/24.
//

import Foundation

@Observable
class CoinWebSocketService{
    //prices : 글로벌 가격에 대한 실시간 변화 추적. => assets에 표시된 값과 일치한다. ','로 seperate된다.
    private let coinPriceUrl = "wss://ws.coincap.io/prices"
    private var session = URLSession(configuration: .default)
    private var webSocketTask : URLSessionWebSocketTask?
    
    var coins : [[String : Double]]? // 결과값은 [코인이름 : 코인가격]으로 response된다.
    
    //선택된 코인을 받아 저장하는 역할 <- View에서 받아와야 된다.
    var selectedCoin : String?
    
    //assets을 받아와 비동기 처리 진행
    //connect()
    func connect() async{
        guard let url = URL(string: coinPriceUrl + "?assets=ALL") else{
            return
        }
        
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        
        do{
            try await receive()
        }catch{
            print("Fail")
        }
    }
    
    //receive()
    private func receive() async throws{
        let response = try await webSocketTask?.receive()
        
        coins = [[:]]
        
        switch response{
        case .string(let text) :
            print("Received CoinPrice: \(text)")
            
            if let data = text.data(using: .utf8),
               let coinPair = try JSONSerialization.jsonObject(with: data) as? [String : String]{
                
                coinPair.forEach{ (key, value) in
                    if let price = Double(value){
                        coins?.append([key : price])
                    }
                }
            }
            
        case .data(let data):
            print("Received CoinPrice: \(data)")
            
        default:
            break
        }
        
        //message이어받기
        try await receive()
    }//recieve() END
    

    
    func disconnect(){
        webSocketTask?.cancel(with: .goingAway, reason: .none)
        webSocketTask = nil
    }
    
    private func reconnect() async {
        disconnect()
        await connect()
    }
    
    
}

//
//  DashBoard.swift
//  coincap_Tracking
//
//  Created by ms k on 9/4/24.
//

import SwiftUI

struct DashBoard: View {
    
    private var coinService = CoinRestfulService_assets()
    private var coinWebSocket = CoinWebSocketService()
    //추후Test
//    private var Trades_coinWebSocket = Trades_CoinWebSocketService()
    
    @State private var coins : [Coin] = []
    @State private var priceChange : [Bool] = [] //바뀌는 항목들 넣어서 true만들고 해당 변화에 대한 항목들 넣어줄 곳
    
    //Grid를 그리는데 여기에 적힌 순서대로 작성된다.
    private var gridItemLayout = [ GridItem(.fixed(50)),
                                   GridItem(.flexible(minimum: 120, maximum: 200)),
                                   GridItem(.flexible()),
                                   GridItem(.flexible())
    ]
    
    
    var body: some View {
        NavigationStack{
            //TopView Start
            HStack{
                Text("순위")
                Text("이름")
                Spacer()
                Text("가격")
                    .padding(.trailing, 10)
                Text("%변동폭")
            }
            .padding(.horizontal, 5)
            .fontWeight(.bold)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color(red: 100/255, green: 100/255, blue: 100/255))//TopView END
                
            //MainView Start
            ScrollView{
                
                Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 15){
                    
                    Section{
                        ForEach(0..<coins.count, id: \.self){ index in
                            GridRow(alignment: .firstTextBaseline){
                                
                                Text(coins[index].rank)
                                
                                VStack(alignment: .leading){
                                    Text(coins[index].name)
                                        .fontWeight(.medium)
                                    
                                    Text(coins[index].symbol)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Text("\(coins[index].price.formatted(.number.precision(.fractionLength(coins[index].price < 1.0 ? 6 : 2))))")
                                    .fontWeight(.medium)
                                    .gridColumnAlignment(.trailing)
                                    .padding(5)
//                                    .background(priceChange[index] ? Color(red: 100/255, green: 100/255, blue: 100/255) : .clear)
                                    .background(priceChange[index] ? .yellow.opacity(0.5) : .clear)
                                
                                Text((coins[index].changePercent/100).formatted(.percent.precision(.fractionLength(2))))
                                    .gridColumnAlignment(.trailing)
                                    .foregroundStyle(coins[index].changePercent > 0.0 ? .green : .red)
                                
                            }
                            //Rectangle()
                            Rectangle()
                                .fill(.tertiary)
                                .frame(height: 1)
                                .gridCellColumns(4)
                        }
                    }header: {
                    
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Coin Tracker")
            .navigationBarTitleDisplayMode(.inline)
            .contentMargins(10, for: .scrollContent)
            
        }
        .task {
            //NavigationStack에 Rest API를 씌우기
            
            //RESTAPI 호출
            coins = await coinService.quoteAllCoins() ?? []
            priceChange = .init(repeating: false, count: coins.count)
            print(":::::RestAPI호출:::::")
            
            //호출한 내용 update
            await coinWebSocket.connect()
            print(":::::coinWebSocket Connect:::::")
        }
        .refreshable {
            coins = await coinService.quoteAllCoins() ?? []
            print("(:::::refreshable:::::")
        }
        .onChange(of: coinWebSocket.coins){ oldValue, newValue in
            newValue?.forEach({ coin in
                updateCoinPrice(coin: coin)
                print(":::::coin update:::::")
            })
        }
        .preferredColorScheme(.dark)
    }
    
    private func updateCoinPrice(coin : [String : Double]){ //coin : CoinWebSocketService에서 받아온 coin
        guard let key = coin.keys.first,
              let value = coin[key] else{
            return
        }
        
        //coin 배열에서 특정 코인의 index를 찾기.
        let index = coins.firstIndex { $0.name.lowercased() == key.lowercased() }
        
        print("Updataing : \(key)_ price = \(value)")
    
        guard let index = index else{
            return
        }
        coins[index].price = value
        
        //가격 변동시 animation주기
        withAnimation(.easeOut.repeatCount(2, autoreverses: true)){
            priceChange[index].toggle()
        }
        
    }
}


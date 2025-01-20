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

//****************환율 정보 넣기 - 안되면 삭제하기****************
    private var currencyService = CurrencyRestfulService()
    @State private var currencyKRW : [Currency] = []
    
    
//추후Test
//    private var Trades_coinWebSocket = Trades_CoinWebSocketService()
    
    @State private var coins : [Coin] = []
    @State private var priceChange : [Bool] = [] //바뀌는 항목들 넣어서 true만들고 해당 변화에 대한 항목들 넣어줄 곳
    //화면 dark모드
    @State private var isBright : Bool = false
    //달라 표시 원화 표시
    @State private var isDollar : Bool = true
    private var priceIcon : String{
        return isDollar ? "$" : "₩"
    }
    
    //DetailView로 넘기기
    @State var showDetailView : Bool = false
    @State var selectedCoinID : String = ""
    
    //Grid를 그리는데 여기에 적힌 순서대로 작성된다.
    private var gridItemLayout = [ GridItem(.fixed(50)),
                                   GridItem(.flexible(minimum: 150, maximum: 200)),
                                   GridItem(.flexible()),
                                   GridItem(.flexible())
    ]
         
    
    var body: some View {
        NavigationStack{
            //TopView Start
            HStack{
                Text("순위")
                    .padding(.trailing, 12)
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
                    
                    Section {
                        
                        ForEach(0..<coins.count, id: \.self){ index in
                            GridRow(alignment: .firstTextBaseline){
                                
                                
                                Text(coins[index].rank)
                                
                                
                                VStack(alignment: .leading){
                                    Text(coins[index].name)
                                        .fontWeight(.medium)
                                        .onTapGesture(perform: {
                                            
                                            selectedCoinID = coins[index].id
                                            showDetailView.toggle()
                                            
                                        })
                                    
                                    Text(coins[index].symbol)
                                        .foregroundStyle(.secondary)
                                }
                                
                                //가격 표시
                                // 가격 포맷팅을 별도 변수로 분리
                                let formattedPrice: String = {
                                    let precision = coins[index].price < 1.0 ? 6 : 2
                                    return coins[index].price.formatted(.number.precision(.fractionLength(precision)))
                                }()

                                // Text에 적용
                                Text("\(formattedPrice) \(priceIcon)")
                                    .fontWeight(.medium)
                                    .gridColumnAlignment(.trailing)
                                    .padding(5)
                                    .background(priceChange[index] ? .yellow.opacity(0.5) : .clear)

                                
                                //변동폭
                                Text((coins[index].changePercent/100).formatted(.percent.precision(.fractionLength(2))))
                                    .gridColumnAlignment(.trailing)
                                    .foregroundStyle(coins[index].changePercent > 0.0 ? .green : .red)
                                
                            }
                            //구분선 표시
                            Rectangle()
                                .fill(.tertiary)
                                .frame(height: 1)
                                .gridCellColumns(4)
                        }
                        
                    }header: {
                        Text("CoinCap API")
                            .font(.title)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Coin Tracker")
            .toolbar(content: {
                Button(action: {
                    isDollar.toggle()
                }, label: {
                    Image(systemName: isDollar ? "dollarsign" : "wonsign")
                        .frame(width: 10)
                })
                
                Button(action: {
                    isBright.toggle()
                }, label: {
                    Image(systemName: isBright ? "lightbulb.fill" : "lightbulb.slash")
                        
                })
                
                
                
                
            })
            .navigationBarTitleDisplayMode(.inline)
            .contentMargins(10, for: .scrollContent)
            
        }
        .task {
            //NavigationStack에 Rest API를 씌우기
            
            //RESTAPI 호출 -> coins 배열을 생성해 priceChange를 통해 해당 항목만큼 배열 생성
            coins = await coinService.quoteAllCoins() ?? []
            //********환율정보 표시 - 안되면 삭제********
//            currencyKRW = await currencyService.quote_KRW("south-korean-won")
//            
            //********안되면삭제 END********
            
            //가격 변동이 발생했을 때 true로 변경해 색깔이 바뀌어야 함을 표시.
            priceChange = .init(repeating: false, count: coins.count)
            print(":::::RestAPI호출:::::")
            print(":::::갯수 : \(coins.count):::::")
            
            //호출한 내용 update
            await coinWebSocket.connect()
            print(":::::coinWebSocket Connect:::::")
        }
//        .refreshable {
//            coins = await coinService.quoteAllCoins() ?? []
//            print("(:::::refreshable:::::")
//        }
        .onChange(of: coinWebSocket.coins){ oldValue, newValue in
            newValue?.forEach({ coin in
                updateCoinPrice(coin: coin)
//                print(":::::coin update:::::")
            })
        }
        .sheet(isPresented: $showDetailView, content: {
            DetailView(selectedId: selectedCoinID)
        })
        .preferredColorScheme(isBright ? .light : .dark) // 테마 바꾸기
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


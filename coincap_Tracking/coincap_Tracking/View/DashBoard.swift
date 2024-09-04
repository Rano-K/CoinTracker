//
//  DashBoard.swift
//  coincap_Tracking
//
//  Created by ms k on 9/4/24.
//

import SwiftUI

struct DashBoard: View {
    
    @State private var coins : [Coin] = []
    @State private var priceChange : [Bool] = [] //바뀌는 항목들 넣어서 true만들고 해당 변화에 대한 항목들 넣어줄 곳
    
    private var gridItemLayout = [ GridItem(.fixed(50)),
                             GridItem(.flexible(minimum: 120, maximum: 200)),
                             GridItem(.flexible()),
                             GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack{
            HStack{
                Text("순위")
                Text("이름")
                Text("가격")
                Text("%변동폭")
            }
            .padding(.horizontal, 5)
            .fontWeight(.bold)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(.yellow.opacity(0.5))
//            .background(.blendMode(.destinationOut))
            
            ScrollView{
                
                Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 15){
                    
                    Section{
                        ForEach(0..<coins.count, id: \.self){ index in
                            GridRow(alignment: .firstTextBaseline, content: {
                                
                                Text(coins[index].rank)
                                
                                VStack(alignment: .leading, content: {
                                    Text(coins[index].name)
                                        .fontWeight(.medium)
                                    
                                    Text(coins[index].symbol)
                                        .foregroundStyle(.secondary)
                                })
                                
                            })
                        }
                    }
                }
            }
        }
        .navigationTitle("COIN")
        .contentMargins(10, for: .scrollContent)
    }
}

//
//  ContentView.swift
//  coincap_Tracking
//
//  Created by ms k on 8/20/24.
//

import SwiftUI

struct ContentView: View {
    
    //test
    private var rows : [GridItem] = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
    ]
    
    
    var body: some View {
//        ScrollView(.horizontal){
//            LazyHGrid(rows: columns, pinnedViews: PinnedScrollableViews(),content: {
//                ForEach((0...10001), id: \.self){ _ in
//                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
//                        .frame(width: 10, height: 10)
//                        .cornerRadius(30, antialiased: false)
//                }
//            })
//        }
        ScrollView(.vertical){
            LazyVGrid(columns: rows, alignment: .center, content: {
                Section{
//                LazyVStack{
                    ForEach((0...10001), id:\.self){_ in
                        Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                            .frame(width: 100, height: 100)
                            .cornerRadius(50)
                    }
                    
                    .shadow(radius: 5 ,x: -10,y: 10)
                    .frame(width: 100, height: 100)
                }
//                Section{
//                    ForEach((0...101), id:\.self){_ in
//                        Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
//                            .frame(width: 50, height: 50)
//                            .cornerRadius(50)
//                    }
//                    .shadow(radius: 5 ,x: -10,y: 10)
//                    .frame(width: 100, height: 50)
//                }
            })
        }
    }
}


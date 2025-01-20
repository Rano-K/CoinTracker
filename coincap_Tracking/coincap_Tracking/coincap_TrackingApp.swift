//
//  coincap_TrackingApp.swift
//  coincap_Tracking
//
//  Created by ms k on 8/20/24.
//

import SwiftUI

@main
struct coincap_TrackingApp: App {
    var body: some Scene {
        WindowGroup {
//            DashBoard()
            TabView{
                DashBoard()
                    .tabItem{
                        Text("1")
                    }
                ContentView()
                    .tabItem{
                        Text("2")
                    }
                TestView()
                    .tabItem{
                        Text("Test")
                    }
                
            }
        }
    }
}

//
//  ContentView.swift
//  LabWeek7
//
//  Created by Jason TIo on 10/04/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PetViewModel()
    
#if os(watchOS)
    var body: some View {
        WatchActionPageView(viewModel: viewModel)
    }
#else
    @State private var selection: String? = "Status"
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                NavigationLink(value: "Status") {
                    Label("Status", systemImage: "heart.fill")
                        .foregroundColor(.blue)
                }
                NavigationLink(value: "Shop") {
                    Label("Shop", systemImage: "cart.fill")
                        .foregroundColor(.blue)
                }
                NavigationLink(value: "About") {
                    Label("About", systemImage: "info.circle")
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle("Tamagochi")
        } detail: {
            if selection == "Status" {
                HomeView(viewModel: viewModel)
            } else if selection == "Shop" {
                ShopView(viewModel: viewModel)
            } else if selection == "About" {
                AboutView()
            } else {
                Text("Select an option")
            }
        }
    }
#endif
}

#Preview {
    ContentView()
}

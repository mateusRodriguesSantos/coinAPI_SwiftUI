//
//  ContentView.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 05/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModelList: ViewModel
    @State var searchList: String = .empty
    
    var body: some View {
        NavigationStack {
            VStack {
                ListView()
            }
            .padding(.zero)
            .navigationTitle("Exchanges")
        }
        .onAppear {
            Task {
                viewModelList.isLoading = true
            }
        }
        .searchable(text: $searchList)
        .onChange(of: searchList) { newValue in
            viewModelList.search(newValue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let exchange = ViewModel()
        ContentView()
            .environmentObject(exchange)
            .onAppear {
                exchange.getMock()
            }
    }
}

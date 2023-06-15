//
//  ListView.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 05/06/23.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(3)
            } else {
                NavigationStack{
                    List {
                        ForEach(viewModel.listExchange) { exchange in
                            NavigationLink {
                                DetailsView(
                                    id: exchange.id,
                                    name: exchange.name ?? .empty)
                            } label: {
                                CurrencyRow(
                                    title: exchange.exchangeID ?? .empty,
                                    describe: String(format: "%.2f", exchange.volume1hrs ?? .zero)
                                )
                            }
                        }
                    }
                }
                .listStyle(.sidebar)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        ListView()
            .environmentObject(viewModel)
            .onAppear {
                viewModel.getMock()
            }
    }
}


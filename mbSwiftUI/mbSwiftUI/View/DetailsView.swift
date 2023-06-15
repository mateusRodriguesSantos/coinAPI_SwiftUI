//
//  DetailsView.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 05/06/23.
//

import SwiftUI

struct DetailsView: View {
    
    @EnvironmentObject var viewModel: ViewModel
        
    var id: Int?
    var name: String = .empty
    var website: String = .empty
    var dataQuoteStart: String = .empty
    var dataQuoteEnd: String = .empty
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                Image("Bitcoin.svg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                Spacer()
            }
            .listRowBackground(Color.clear)
            .padding(.inset([.top(number: 15), .bottom(number: 20)]))
            
            
            VStack(alignment: .leading) {
                DescriptionRow(title: "Website", description: viewModel.exchangeDetail?.website ?? .empty)
                DescriptionRow(
                    title: "Quote Start",
                    description: viewModel.exchangeDetail?.dataStart ?? .empty
                    )
                DescriptionRow(
                    title: "Quote End",
                    description: viewModel.exchangeDetail?.dataEnd ?? .empty
                    )
                DescriptionRow(
                    title: "Dolar today",
                    description: "\(viewModel.exchangeDetail?.volume1hrs ?? .zero)"
                    )
                DescriptionRow(
                    title: "Dolar yesterday",
                    description: "\(viewModel.exchangeDetail?.volume1DayUsd ?? .zero)"
                    )
                DescriptionRow(
                    title: "Dolar last Month",
                    description: "\(viewModel.exchangeDetail?.volume1month ?? .zero)"
                    )
            }
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
                .fill(.white)
            )
            .padding(.inset(leading: 20, trailing: 20))
            .padding(.inset(bottomSpace: 15))
            
   
            NavigationLink("Symbols") {
                ListHistoricSymbol(exchangeID: viewModel.exchangeDetail?.exchangeID ?? .empty)
            }
        }
        .background(Color(.systemGray5), ignoresSafeAreaEdges: [])
        .navigationTitle(name)
        .onAppear {
            Task {
                viewModel.getExchangeById(id ?? .zero)
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            let viewModel = ViewModel()
            DetailsView()
                .environmentObject(viewModel)
                .onAppear {
                    viewModel.getMock()
                    viewModel.getExchangeById(viewModel.listExchange.first?.id ?? .zero)
                }
        }
    }
}

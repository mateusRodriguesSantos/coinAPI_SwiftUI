//
//  ViewModel.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 10/06/23.
//

import Foundation

class ViewModel: ObservableObject {
    
    private let dispatch: DispatchQueueTypeProtocol
    private let metadata: MetadataProtocol
    private let tradesData: TradesDataProtocol
    
    @Published var listExchange: [Exchange] = []
    @Published var listAsset: [Asset] = []
    @Published var listSymbol: [Symbol] = []
    @Published var exchangeDetail: Exchange?
    @Published var dataImage: Data?
    @Published var trade: [Historic] = []
    @Published var isLoading: Bool = false
    
    var listExchangeTotal: [Exchange] = []
    
    init(
        dispatch: DispatchQueueTypeProtocol = DispatchQueueType(),
        metadata: MetadataProtocol = MetadataStruct(),
        tradesData: TradesDataProtocol = TradesDataStruct()
    ) {
        self.dispatch = dispatch
        self.metadata = metadata
        self.tradesData = tradesData
    }
    
    public func getMetadata() {
        metadata.metadataExchanges { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case let .success(data):
                dispatch.main_async {
                    self.listExchange = data
                    self.listExchangeTotal = data
                    self.isLoading = false
                }
            case let .failure(error):
                print(error)
                dispatch.main_async {
                    self.listExchange = []
                    self.listExchangeTotal = []
                }
            }
        }
    }
    
    public func getMetadataAssets() {
        metadata.metadataAssets { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case let .success(data):
                dispatch.main_async {
                    self.listAsset = data
                    self.isLoading = false
                }
            case let .failure(error):
                print(error)
                dispatch.main_async {
                    self.listAsset = []
                }
            }
        }
    }

    public func getMetadataSymbols() {
        metadata.metadataSymbols { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case let .success(data):
                dispatch.main_async {
                    self.listSymbol = data
                    self.isLoading = false
                }
            case let .failure(error):
                print(error)
                dispatch.main_async {
                    self.listSymbol = []
                }
            }
        }
    }
    
    public func getMetadataSymbols(exchangeID: String) {
        metadata.metadataSymbols(exchangeID: exchangeID) { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case let .success(data):
                dispatch.main_async {
                    self.listSymbol = data
                    self.isLoading = false
                }
            case let .failure(error):
                print(error)
                dispatch.main_async {
                    self.listSymbol = []
                }
            }
        }
    }
    
    public func getExchangeById(_ id: Int) {
        exchangeDetail = listExchange.first(where: { $0.id == id }) ?? nil
    }
    
    var symbolID: String {
        return listSymbol.first { symbol in
            symbol.exchangeID == exchangeDetail?.exchangeID
        }?.symbolID ?? .empty
    }
    
    public func historicalTradesData() {
        guard let symbol = listSymbol.first(where: { $0.symbolID == symbolID }) else { return }
        tradesData.historicalTradesData(symbol: symbol.symbolID ?? .empty, timeStart: symbol.dataStart ?? .empty, timeEnd: .empty, limit: 100) { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case let .success(data):
                dispatch.main_async {
                    self.trade = data
                    self.isLoading = false
                }
            case let .failure(error):
                print(error)
                dispatch.main_async {
                    self.trade = []
                }
            }
        }
    }
    
    public func getMock() {
        listExchange = BundleManager.getArchieveJson()
        listExchangeTotal = listExchange
    }
    
    public func search(_ text: String) {
        if text.isEmpty {
            listExchange = listExchangeTotal
        } else {
            listExchange = listExchange.filter { exchange in
                guard let name = exchange.name else { return false }
                return name.contains(text)
            }
        }
    }
}

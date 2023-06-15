//
//  ViewModelTest.swift
//  mbSwiftUITests
//
//  Created by Mateus Rodrigues on 15/06/23.
//

import XCTest
@testable import mbSwiftUI

final class ViewModelTest: XCTestCase {

    var sut: ViewModel!
    var dispatchQueueFake: DispatchQueueFake!
    var stubMetadata: MetadataStub!
    var stubTradesData: TradesDataStub!
    
    override func setUpWithError() throws {
        dispatchQueueFake = DispatchQueueFake()
        stubMetadata = MetadataStub()
        stubTradesData = TradesDataStub()
        sut = ViewModel(dispatch: dispatchQueueFake, metadata: stubMetadata, tradesData: stubTradesData)
    }

    override func tearDownWithError() throws {
        dispatchQueueFake = nil
        stubMetadata = nil
        stubTradesData = nil
        sut = nil
    }

    func testGetMetadataSuccess() {
        stubMetadata.isSuccess = true
        sut.getMetadata()
        
        XCTAssertEqual(sut.listExchange.first?.exchangeID, "AAX")
    }
    
    func testGetMetadataError() {
        sut.getMetadata()
        
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.listExchange.isEmpty)
    }
    
    func testGetMetadataAssetsSuccess() {
        stubMetadata.isSuccess = true
        sut.getMetadataAssets()
        
        XCTAssertEqual(sut.listAsset.first?.assetID, "OAX")
    }
    
    func testGetMetadataAssetsError() {
        sut.getMetadataAssets()
        
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.listAsset.isEmpty)
    }
    
    func testGetMetadataSymbolsSuccess() {
        stubMetadata.isSuccess = true
        sut.getMetadataSymbols()
        
        XCTAssertEqual(sut.listSymbol.first?.symbolID, "BINANCEOPTV_OPT_BTC_USDT_220128_38000_C")
    }
    
    func testGetMetadataSymbolsError() {
        sut.getMetadataSymbols()
        
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.listSymbol.isEmpty)
    }
    
    func testGetMetadataSymbolsByExchangeSuccess() {
        stubMetadata.isSuccess = true
        sut.getMetadataSymbols(exchangeID: "AAB")
        
        XCTAssertEqual(stubMetadata.paramGetSymbols, "AAB")
        XCTAssertEqual(sut.listSymbol.first?.symbolID, "BTC-220114-52000-P")
    }
    
    func testGetMetadataSymbolsByExchangeError() {
        stubMetadata.isSuccess = false
        sut.getMetadataSymbols(exchangeID: "AAB")
        
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(stubMetadata.paramGetSymbols, "AAB")
        XCTAssertTrue(sut.listSymbol.isEmpty)
    }
    
    func testGetExchangeDetail() throws {
        stubMetadata.isSuccess = true
        sut.getMetadata()
        
        let exchangeFirst = try XCTUnwrap(sut.listExchange.first?.id ?? .zero)
        sut.getExchangeById(exchangeFirst)
        
        XCTAssertEqual(sut.listExchange.first?.exchangeID, "AAX")
        XCTAssertEqual(sut.exchangeDetail?.exchangeID, "AAX")
    }
    
    func testGetSymbolID() {
        sut.exchangeDetail = stubMetadata.exchangeDetail
        sut.listSymbol = stubMetadata.symbol
        
        XCTAssertEqual(sut.symbolID, "BTC-220114-52000-P")
    }
    
    func testHistoricalTradesDataSuccess() {
        stubTradesData.isSuccess = true
        sut.exchangeDetail = stubMetadata.exchangeDetail
        sut.listSymbol = stubMetadata.symbol
        
        sut.historicalTradesData()
        
        XCTAssertEqual(sut.trade.first?.symbolID, "BINANCE")
    }
    
    func testHistoricalTradesDataError() {
        stubTradesData.isSuccess = false
        sut.exchangeDetail = stubMetadata.exchangeDetail
        sut.listSymbol = stubMetadata.symbol
        
        sut.historicalTradesData()
        
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.trade.isEmpty)
    }
    
    func testSearch() {
        stubMetadata.isSuccess = true
        sut.listExchange = stubMetadata.listExchange
        sut.search("AAC")
        
        XCTAssertEqual(sut.listExchange.count, 1)
    }
    
    func testSearchEmpty() {
        stubMetadata.isSuccess = true
        sut.getMetadata()
        sut.search(.empty)
        
        XCTAssertEqual(sut.listExchange.count, 1)
    }
}

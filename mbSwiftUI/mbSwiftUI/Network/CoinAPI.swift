//
//  CoinAPI.swift
//  mbSwiftUI
//
//  Created by MateusRodrigues on 10/06/23.
//

import Foundation

/** BASE API URL **/
fileprivate let COINAPI_URL = "https://rest.coinapi.io"
/** HEADER NAME **/
fileprivate let HEADER_API_KEY = "X-CoinAPI-Key"

/** Handler block **/
typealias APIResponse<T: Decodable> = ((Result<T, CoinAPIError>) -> Void)

/** Error Handler **/
enum CoinAPIError: Error {
    case invalidRequest
    case invalidJSON
    case unknown
}

struct NetworkPerform {
    
    private static var api_key: String {
        return "7F5BD6F2-D2E8-4BCC-AD42-08094BAB510E"
    }
    
    public static func perform<T: Decodable>(request: NSMutableURLRequest, completionHandler: @escaping APIResponse<T>) {
        request.addValue(api_key, forHTTPHeaderField: HEADER_API_KEY)
        
        performRequest(urlRequest: request as URLRequest, completionHandler: completionHandler)
    }
    
    
    public static func performData(request: NSMutableURLRequest, completionHandler: @escaping APIResponse<Data>) {
        request.addValue(api_key, forHTTPHeaderField: HEADER_API_KEY)
        
        performRequest(urlRequest: request as URLRequest, completionHandler: completionHandler)
    }
    
    /*
     * Perform URLRequest and return data based on the API response.
     **/
    private static func performRequest<T: Decodable>(urlRequest: URLRequest, completionHandler: @escaping APIResponse<T>) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let responseData = data else {
                completionHandler(.failure(CoinAPIError.unknown))
                return
            }
            
            do {
                #if DEBUG
                    let str = String(decoding: responseData, as: UTF8.self)
                    print(str)
                    print(T.self)
                #endif
                
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(T.self, from: responseData)
               
                completionHandler(.success(jsonResponse))
            } catch {
                print(error.localizedDescription)
                completionHandler(.failure(CoinAPIError.invalidJSON))
            }
            
        }
        
        task.resume()
    }
    
    /*
     * Perform URLRequest and return data based on the API response.
     **/
    private static func performRequestData(urlRequest: URLRequest, completionHandler: @escaping APIResponse<Data>) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let responseData = data else {
                completionHandler(.failure(CoinAPIError.unknown))
                return
            }
            
            completionHandler(.success(responseData))
        }
        
        task.resume()
    }
}

/** Metadata Functions **/
protocol MetadataProtocol {
    func metadataExchanges(completionHandler: @escaping APIResponse<[Exchange]>)
    func metadataAssets(completionHandler: @escaping APIResponse<[Asset]>)
    func metadataSymbols(completionHandler: @escaping APIResponse<[Symbol]>)
    func metadataSymbols(exchangeID: String, completionHandler: @escaping APIResponse<[Symbol]>)
}

/** Metadata Functions **/
protocol IconsProtocol {
    func icons(completionHandler: @escaping APIResponse<[ImageExchange]>)
    func getData(from url: String, completionHandler: @escaping APIResponse<Data>)
}

/** Exchange Rates Functions **/
protocol ExchangeRatesProtocol {
    func exchangeRatesBy(assetId base: String, idQuote: String, time: Int, completionHandler: @escaping APIResponse<Exchange>)
    func allExchangeRatesBy(assetId base: String, completionHandler: @escaping APIResponse<Exchange>)
}

/** Open, High, Low, Close Prices and Volume indicators Functions **/
protocol OHLCVDataProtocol {
    func allOHLCVPeriods(completionHandler: @escaping APIResponse<String>)
    func latestOHLCVData(symbol id: String, periodId: String, limit: Int, completionHandler: @escaping APIResponse<String>)
    func historialOHLCVData(symbol id: String, periodId: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse<String>)
}

/** Trades Functions **/
protocol TradesDataProtocol {
    func latestTradesData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse<String>)
    func historicalTradesData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse<[Historic]>)
}

/** Quotes Functions **/
protocol QuotesDataProtocol {
    func currentQuotesData(symbol id: String, completionHandler: @escaping APIResponse<String>)
    func latestQuotesData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse<String>)
    func historicalQuotesData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse<String>)
}

/** Orderbooks Functions **/
protocol OrderbooksDataProtocol {
    func currentOrderBooksData(symbol id: String, completionHandler: @escaping APIResponse<String>)
    func latestOrderBooksData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse<String>)
    func historicalOrderBooksData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse<String>)
}

// MARK: - Metadata Implementation
extension MetadataProtocol {
    func metadataExchanges(completionHandler: @escaping APIResponse<[Exchange]>) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/exchanges")) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        
        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }

    func metadataAssets(completionHandler: @escaping APIResponse<[Asset]>) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/assets")) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
  
        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
    func metadataSymbols(completionHandler: @escaping APIResponse<[Symbol]>) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/symbols")) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
    func metadataSymbols(exchangeID: String, completionHandler: @escaping APIResponse<[Symbol]>) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/symbols?filter_symbol_id=\(exchangeID)")) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }

        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
}

extension IconsProtocol {
    
    func getData(from url: String, completionHandler: @escaping APIResponse<Data>) {
        guard let requestUrl = URL(string: url) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.performData(request: request, completionHandler: completionHandler)
    }
    
    func icons(completionHandler: @escaping APIResponse<[ImageExchange]>) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/assets/icons/32")) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
}

// MARK: - Metadata Implementation
extension ExchangeRatesProtocol {
    
    func exchangeRatesBy(assetId base: String, idQuote: String, time: Int, completionHandler: @escaping APIResponse<Exchange>) {
        // build URI string
        var requestResource = "/v1/exchangerate/\(base)/\(idQuote)"
        if time > 0 {
            requestResource = "/v1/exchangerate/\(base)/\(idQuote)?time=\(time)"
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
    func allExchangeRatesBy(assetId base: String, completionHandler: @escaping APIResponse<Exchange>) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/exchangerate/\(base)")) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
}

// MARK: - OHLCV Implementation
extension OHLCVDataProtocol {
    
    func allOHLCVPeriods(completionHandler: @escaping APIResponse<String>) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/ohlcv/periods")) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
    func latestOHLCVData(symbol id: String, periodId: String, limit: Int, completionHandler: @escaping APIResponse<String>) {
        // build URI string
        var requestResource = "/v1/ohlcv/\(id)/latest?period_id=\(periodId)"
        if limit > 0 {
            requestResource = "/v1/ohlcv/\(id)/latest?period_id=\(periodId)&limit=\(limit)"
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
    func historialOHLCVData(symbol id: String, periodId: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse<String>) {
        // build URI string
        var requestResource = "/v1/ohlcv/\(id)/latest?period_id=\(periodId)&time_start=\(timeStart)"
        
        if !timeEnd.isEmpty {
            requestResource.append("&time_end=\(timeEnd)")
        }
        if limit > 0 {
            requestResource.append("&limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
  
        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
}

// MARK: - Trades Implementation
extension TradesDataProtocol {
    
    func latestTradesData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse<String>) {
        // build URI string
        var requestResource = "/v1/trades/latest"
        
        if !id.isEmpty {
            requestResource.append("trades/\(id)/latest")
        }
        if limit > 0 {
            requestResource.append("?limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
    func historicalTradesData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse<[Historic]>) {
        // build URI string
        var requestResource = "/v1/trades/\(id)/history?time_start=\(timeStart)"
        
        if !timeEnd.isEmpty {
            requestResource.append("&time_end=\(timeEnd)")
        }
        if limit > 0 {
            requestResource.append("&limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
}

// MARK: - Quotes Implementation
extension QuotesDataProtocol {
    
    func currentQuotesData(symbol id: String, completionHandler: @escaping APIResponse<String>) {
        // build URI string
        var requestResource = "/v1/quotes/current"
        
        if !id.isEmpty {
            requestResource.append("/v1/quotes/\(id)/current")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
    func latestQuotesData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse<String>) {
        // build URI string
        var requestResource = "/v1/quotes/latest"
        
        if !id.isEmpty {
            requestResource = "/v1/quotes/\(id)/latest"
        }
        if limit > 0 {
            requestResource.append("?limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
   
        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
    func historicalQuotesData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse<String>) {
        // build URI string
        var requestResource = "/v1/quotes/\(id)/history?time_start=\(timeStart)"
        
        if !timeEnd.isEmpty {
            requestResource.append("&time_end=\(timeEnd)")
        }
        if limit > 0 {
            requestResource.append("&limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
}

// MARK: - Order Books Implementation
extension OrderbooksDataProtocol {
    
    func currentOrderBooksData(symbol id: String, completionHandler: @escaping APIResponse<String>) {
        // build URI string
        var requestResource = "/v1/orderbooks/current"
        
        if !id.isEmpty {
            requestResource.append("/v1/orderbooks/\(id)/current")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
    func latestOrderBooksData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse<String>) {
        // build URI string
        var requestResource = "/v1/orderbooks/\(id)/latest"
        
        if limit > 0 {
            requestResource.append("?limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
    func historicalOrderBooksData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse<String>) {
        // build URI string
        var requestResource = "/v1/quotes/\(id)/history?time_start=\(timeStart)"
        
        if !timeEnd.isEmpty {
            requestResource.append("&time_end=\(timeEnd)")
        }
        if limit > 0 {
            requestResource.append("&limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(.failure(CoinAPIError.invalidRequest))
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"

        // Perform request
        NetworkPerform.perform(request: request, completionHandler: completionHandler)
    }
    
}

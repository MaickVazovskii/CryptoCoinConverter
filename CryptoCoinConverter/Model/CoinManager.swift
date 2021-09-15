//
//  CoinManager.swift
//  CryptoCoinConverter
//
//  Created by Тимур Гутиев on 10.09.2021.
//

import Foundation

protocol CoinManagerDelegate {
    func displayCoinData(from: CoinData)
}
  
struct CoinManager {
    
    var selectionDelegate: CoinManagerDelegate?
    
    let currency: [String] = ["USD", "EUR", "RUB", "GBP", "CHF", "JPY"]
    let coinNames: [String] = ["BTC", "XRP", "ETH", "LTC", "DOGE"]
    
    let HTTPS = "https://rest.coinapi.io/v1/exchangerate/"
    let myAppID = "300B2461-E145-42B2-B668-C74E66F9E79B"
    
    func getCoinPrice(for currency: String, for coin: String) { // получаем данные для валюты и коина
        let urlString = "\(HTTPS)\(coin)/\(currency)?apikey=\(myAppID)"
        performRequest(with: urlString)
    }
        
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url, completionHandler: {(coinData: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = coinData { // полученные данные в формете JSON
                    if let parsedData = parseJSON(from: safeData) { // преобразованные данные из формата JSON
                        self.selectionDelegate?.displayCoinData(from: parsedData)
                    }
                }
            })
            task.resume()
        }
    }
    
}
    
    func parseJSON(from receivedCoinData: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: receivedCoinData)
            print(decodedData.rate)
            let currency = decodedData.asset_id_quote
            let price = decodedData.rate
            
            let coinInfo = CoinData(asset_id_quote: currency, rate: price)
            return coinInfo
            
        }catch{
            print(error)
            return nil
        }
    }

    
    

//
//  CoinData.swift
//  CryptoCoinConverter
//
//  Created by Тимур Гутиев on 10.09.2021.
//

import Foundation

struct CoinData: Codable {
    
    let asset_id_quote: String
    let rate: Double
    
    var rateString: String {
        return String(format: "%.1f", rate)
    }
}

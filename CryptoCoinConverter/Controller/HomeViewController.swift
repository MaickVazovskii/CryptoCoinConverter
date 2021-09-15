//
//  HomeViewController.swift
//  CryptoCoinConverter
//
//  Created by Тимур Гутиев on 08.09.2021.
//

import UIKit

class HomeViewController: UIViewController, UIPickerViewDataSource {
    
    var coinManager = CoinManager()
    
    let secondVCImageView: UIImageView = {
        let secondVCImageView = UIImageView()
        secondVCImageView.frame = UIScreen.main.bounds
        secondVCImageView.backgroundColor = UIColor(red: 87/255, green: 204/255, blue: 153/255, alpha: 1.0)
        secondVCImageView.contentMode = .scaleAspectFit
        return secondVCImageView
    }()
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var amountOfSum: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(secondVCImageView)
        view.addSubview(pickerView)
        view.addSubview(currencyImage)
        view.addSubview(currencyName)
        view.addSubview(amountOfSum)
        
        coinManager.selectionDelegate = self
        pickerView.delegate = self
        pickerView.dataSource = self 
        
    }

}
// MARK: - UIPickerDelegate

extension HomeViewController: UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return coinManager.coinNames.count
        case 1:
            return coinManager.currency.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return coinManager.coinNames[row]
        } else {
            return coinManager.currency[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCoin = coinManager.coinNames[(pickerView.selectedRow(inComponent: 0))]
        let selectedCurrency = coinManager.currency[(pickerView.selectedRow(inComponent: 1))]
        
        coinManager.getCoinPrice(for: selectedCurrency, for: selectedCoin)
        
        let imageSelected = coinManager.coinNames[pickerView.selectedRow(inComponent: 0)]
        currencyImage.image = UIImage(named: imageSelected)
    }
    
}

// MARK: - CoinManagerDelegate

extension HomeViewController: CoinManagerDelegate {
    
    func displayCoinData(from: CoinData) {
        DispatchQueue.main.async {
            self.amountOfSum.text = from.rateString
            self.currencyName.text = from.asset_id_quote
        }
        
    }
    
    
    
}

//
//  CovidManager.swift
//  TableView
//
//  Created by Engr. John Raymond Ilagan on 9/12/20.
//  Copyright © 2020 John Raymond Ilagan. All rights reserved.
//

import Foundation

protocol CovidManagerDelegate {
    func didUpdateSummary(covidManager: CovidManager, summary: CovidModel)
    func didFailWithError(error: Error)
}

struct CovidManager {
    
    var delegate: CovidManagerDelegate?
    
    func fetchCountry() {
        performRequest(with: K.summaryURL)
    }
    
    func performRequest(with urlstring: String) {
        if let url = URL(string: urlstring) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let summary = self.parseJSON(covidData: safeData) {
                        self.delegate?.didUpdateSummary(covidManager: self, summary: summary)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(covidData: Data) -> CovidModel? {
        
        let decoder = JSONDecoder()
        
        var countryArray = [String]()
        var totalArray = [Int]()

        do {
            let decodedData = try decoder.decode(CovidData.self, from: covidData)
            
            //Fix
            for num in 0...187 {
                let countryData = decodedData.Countries[num].Country
                let totalData = decodedData.Countries[num].TotalConfirmed
                countryArray.append(countryData)
                totalArray.append(totalData)
            }
            
            let covidModelOuput = CovidModel(country: countryArray, totalConfirmed: totalArray)
        
            return covidModelOuput
            
        } catch {
            print(error)
            
            return nil
        }
    }
    
}

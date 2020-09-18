//
//  SummaryViewController.swift
//  TableView
//
//  Created by Engr. John Raymond Ilagan on 9/13/20.
//  Copyright © 2020 John Raymond Ilagan. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController, CovidManagerDelegate {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var totalConfirmedLabel: UILabel!
    var countryArray = CovidModel(country: [], totalConfirmed: [])
    var covidManager = CovidManager()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryLabel.text = ""
        totalConfirmedLabel.text = ""
        covidManager.delegate = self
        covidManager.fetchCountry()
    }
    
    func didUpdateSummary(covidManager: CovidManager, summary: CovidModel) {
        DispatchQueue.main.async {
            self.countryLabel.text =  summary.country[self.index]
            self.totalConfirmedLabel.text = "\(summary.totalConfirmed[self.index])"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}

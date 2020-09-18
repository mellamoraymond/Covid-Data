//
//  ListViewController.swift
//  TableView
//
//  Created by Engr. John Raymond Ilagan on 9/11/20.
//  Copyright © 2020 John Raymond Ilagan. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    //MARK: - Global Variables
    
    var countryArray = CovidModel(country: [], totalConfirmed: [])
    var covidManager = CovidManager()
    
    
    //MARK: - View Did Load Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        covidManager.delegate = self
        covidManager.fetchCountry()
    }
    
    //MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row was tapped")
        print(indexPath.row)
    }
    
    //MARK: - Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray.country.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        cell.textLabel?.text = countryArray.country[indexPath.row]
        
        return cell
    }
    
    //MARK: - Prepare for Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            let summaryVC = segue.destination as! SummaryViewController
            summaryVC.index = selectedRow
        }
    }

}

//MARK: - Covid Manager Delegate Methods

extension ListViewController: CovidManagerDelegate {
    
    func didUpdateSummary(covidManager: CovidManager, summary: CovidModel) {
        DispatchQueue.main.async {
            print(summary.country)
            self.countryArray.country = summary.country
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}


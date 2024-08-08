//
//  SearchTabController.swift
//  ScamAllert
//
//  Created by Andreas Hartanto on 2024-08-08.
//

import UIKit

class SearchTabController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    var models: [(title: String, detail: String)] = []
    var filteredModels: [(title: String, detail: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        title = "Search"
        
        // Initially, filtered models should be the same as the full models
        filteredModels = models
    }
    
    // MARK: - TableView DataSource and Delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredModels[indexPath.row].title
        cell.detailTextLabel?.text = filteredModels[indexPath.row].detail
        return cell
    }
    
    // MARK: - UISearchBar Delegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredModels = models
        } else {
            filteredModels = models.filter({ $0.title.lowercased().contains(searchText.lowercased()) })
        }
        tableView.reloadData()
    }
}

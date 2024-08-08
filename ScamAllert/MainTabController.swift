//
//  MainTabController.swift
//  ScamAllert
//
//  Created by Andreas Hartanto on 2024-08-08.
//

import UIKit

class MainTabController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    
    var models: [(title: String, detail: String)] = []
    var filteredModels: [(title: String, detail: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        title = "Articles"
        
        // Initially show all models
        filteredModels = models
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = filteredModels[indexPath.row]
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.detail
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = filteredModels[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "article") as? ArticleViewController else {
            return
        }
        vc.title = "Article"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.articleTitle = model.title
        vc.article = model.detail
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredModels = models
        } else {
            filteredModels = models.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func didTapSave(_ sender: UIButton) {
        guard let titleText = titleField.text, !titleText.isEmpty,
              let detailText = detailField.text, !detailText.isEmpty else {
            // Handle empty fields
            return
        }
        
        // Add new article
        models.append((title: titleText, detail: detailText))
        filteredModels = models // Update filtered models
        tableView.reloadData() // Refresh table view
        
        // Clear text fields
        titleField.text = ""
        detailField.text = ""
    }
}


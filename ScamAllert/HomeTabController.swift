//
//  HomeTabController.swift
//  ScamAllert
//
//  Created by Andreas Hartanto on 2024-07-12.
//

import Foundation
import UIKit


class HomeTabController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITabBarControllerDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    var models: [(title: String, detail: String)] = []
    var filteredModels: [(title: String, detail: String)] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self
        title = "Article"
        table.isHidden = models.isEmpty
        label.isHidden = !models.isEmpty
        tabBarController?.delegate = self
        
        // Initially show all models
        filteredModels = models
        
    }
    
    @IBAction func didCreateNewArticle() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "new") as? CreateTabController else {
            return
        }
        
        vc.completion = { [weak self] articleTitle, articleDetail in
            guard let strongSelf = self else { return }
            strongSelf.models.append((title: articleTitle, detail: articleDetail))
            strongSelf.filteredModels = strongSelf.models
            strongSelf.updateUI()
            strongSelf.table.reloadData()
            strongSelf.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // TableView DataSource and Delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredModels[indexPath.row].title
        cell.detailTextLabel?.text = filteredModels[indexPath.row].detail
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
    // search function
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredModels = models
        } else {
            filteredModels = models.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        table.reloadData()
    }
    // Helper to update UI based on data
       private func updateUI() {
           table.isHidden = models.isEmpty
           label.isHidden = !models.isEmpty
       }
}


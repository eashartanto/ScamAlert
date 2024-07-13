//
//  HomeTabController.swift
//  ScamAllert
//
//  Created by Andreas Hartanto on 2024-07-12.
//

import Foundation
import UIKit


class HomeTabController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    var models: [(title: String, article: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        title = "Article"
    }

    @IBAction func didCreateNewArticle(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "new") as? CreateTabController else {
            return
        }
//        vc.title = "New Article"
//        navigationController?.pushViewController(vc, animated: true)
     
        tabBarController?.selectedIndex = 1
    }
    //table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].article
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // show note controller
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "article") as? ArticleViewController else{
            return
        }
        vc.title = "Article"
        navigationController?.pushViewController(vc, animated: true)
    }
}


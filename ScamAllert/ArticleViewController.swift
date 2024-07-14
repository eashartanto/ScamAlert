//
//  ArticleViewController.swift
//  ScamAllert
//
//  Created by Andreas Hartanto on 2024-07-13.
//

import UIKit

class ArticleViewController: UIViewController {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    public var articleTitle: String = ""
    public var article: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = articleTitle
        detailLabel.text = article
        // Do any additional setup after loading the view.
    }

}

//
//  CreateTabController.swift
//  ScamAllert
//
//  Created by Andreas Hartanto on 2024-07-13.
//

import Foundation
import UIKit

class CreateTabController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var detailField: UITextField!
    @IBOutlet var phoneNumField: UITextField!
    @IBOutlet var emailField: UITextField!
    
    public var completion: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    

    @objc func didTapSave() {
        if let titleText = titleField.text, !titleText.isEmpty,
                   let detailText = detailField.text, !detailText.isEmpty {
                    completion?(titleText, detailText)
        }
    }


}

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
    
    var homeTabController: HomeTabController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        
        guard let titleText = titleField.text, !titleText.isEmpty,
              let detailText = detailField.text, !detailText.isEmpty else {
            return
        }
        
        // Pass the data back using the completion closure
        completion?(titleText, detailText)
        
        // Dismiss the view controller after saving
        navigationController?.popViewController(animated: true)
    }
    
}

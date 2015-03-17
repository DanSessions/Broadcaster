//
//  ExternalScreenViewController.swift
//  Broadcaster
//
//  Created by Dan on 17/03/2015.
//  Copyright (c) 2015 Daniel Sessions. All rights reserved.
//

import UIKit

class ExternalScreenViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var initialDisplayText: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initialDisplayText = displayLabel.text
        
    }

    func displayText(text: String) {
        
        if countElements(text) == 0 {
            displayLabel.text = initialDisplayText
        } else {
            displayLabel.text = text
        }
        
    }
    
}

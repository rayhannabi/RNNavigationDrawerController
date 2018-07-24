//
//  SecondViewController.swift
//  NavigationDrawerTest
//
//  Created by Rayhan Janam on 6/24/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import UIKit
import RNNavigationDrawerController

class SecondViewController: UIViewController, RNChildViewController {

    var delegate: RNChildViewControllerDelegate?
    
    var shouldEmbedInNavigationController: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        delegate?.toggleNavigationPanel()
    }

}

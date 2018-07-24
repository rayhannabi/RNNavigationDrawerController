//
//  FourthViewController.swift
//  NavigationDrawerTest
//
//  Created by Rayhan Janam on 6/25/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import UIKit
import RNNavigationDrawerController

class FourthViewController: UIViewController, RNChildViewController {
    
    var delegate: RNChildViewControllerDelegate?
    
    var shouldEmbedInNavigationController: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func menuTapped(_ sender: Any) {
        delegate?.toggleNavigationPanel()
    }
    
}

extension FourthViewController {
    
    func setStyle(for navigationController: UINavigationController) {
        
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        
        navigationController.navigationBar.titleTextAttributes = [ .foregroundColor : UIColor.darkGray]
        
    }
}

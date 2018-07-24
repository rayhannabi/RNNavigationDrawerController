//
//  RNChildViewControllerDelegate.swift
//  NavigationDrawerTest
//
//  Created by Rayhan Janam on 6/24/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import UIKit


/// A protocol that performs tasks of navigation panel when interacting with [RNChildViewController](file://)
@objc protocol RNChildViewControllerDelegate {
    
    /// Toggles Navigation Panel Controller
    @objc func toggleNavigationPanelController()

}


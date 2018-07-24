//
//  RNChildViewControllerDelegate.swift
//  RNNavigationDrawerController
//
//  Created by Rayhan Janam on 6/26/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import Foundation

/// A protocol that performs tasks of navigation panel when interacting with [RNChildViewController](file://)
@objc public protocol RNChildViewControllerDelegate {
    
    /// Toggles Navigation Panel Controller
    @objc func toggleNavigationPanel()
}

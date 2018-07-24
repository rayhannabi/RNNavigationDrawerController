//
//  RNNavigationPanelController.swift
//  NavigationDrawerTest
//
//  Created by Rayhan Janam on 6/25/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import Foundation

/// A protocol for providing the navigation controller
///
/// View Controller which is to be used as Navigation Controller must conform to this protocol
protocol RNNavigationPanelController {
    
    /// Navigation menu items
    ///
    /// Must return an array of [RNNavigationMenuItem](file://)
    var navigationMenuItems: [RNNavigationMenuItem] { get }
    
    /// The delegate for this object
    ///
    /// Delegate is notified whenever interaction happens in Navigation Panel Controller
    var delegate: RNNavigationPanelControllerDelegate? { get set }
    
}

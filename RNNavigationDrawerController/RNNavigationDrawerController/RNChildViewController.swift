//
//  RNChildViewController.swift
//  RNNavigationDrawerController
//
//  Created by Rayhan Janam on 6/26/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import Foundation

/// A protocol for child view controllers.
///
/// View controllers which are to be added as the children of the [RNContainerViewController](file://) must conform to this protocol
@objc public protocol RNChildViewController {
    
    var delegate: RNChildViewControllerDelegate? { get set }
    var shouldEmbedInNavigationController: Bool { get }
    
    @objc optional func setStyle(for navigationController: UINavigationController)
}

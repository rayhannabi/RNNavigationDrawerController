//
//  RNNavigationPanelController.swift
//  RNNavigationDrawerController
//
//  Created by Rayhan Janam on 6/26/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import Foundation

public protocol RNNavigationPanelController {
    
    var navigationMenuItems: [RNNavigationMenuItem] { get }
    var delegate: RNNavigationPanelControllerDelegate? { get set }
    
}

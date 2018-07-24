//
//  RNStoryboardDelegate.swift
//  RNNavigationDrawerController
//
//  Created by Rayhan Janam on 6/26/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import Foundation

/// The delegate which is required by [RNContainerViewController](file://) to fetch view controllers
///
/// Create a class and conform to this protocol to provide the navigation panel controller and the child view controllers.
/// Then set the class as the storyboardDelegate property of the [RNContainerViewController](file://) object
public protocol RNStoryboardDelegate {
    
    /// Gets the navigation panel controller from storyboard
    ///
    /// - Returns: Navigation panel controller
    func getNavigationPanelController() -> RNNavigationPanelController?
    
    
    /// Gets the view controllers to be added as children of the container
    ///
    /// - Parameter identifier: Storyboard ID of a view controller.
    /// - Returns: Child view controllers
    func getChildViewController(withIdentifier identifier: String) -> RNChildViewController?
    
}

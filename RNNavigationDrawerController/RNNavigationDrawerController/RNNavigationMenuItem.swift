//
//  RNNavigationMenuItem.swift
//  RNNavigationDrawerController
//
//  Created by Rayhan Janam on 6/26/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import Foundation

public struct RNNavigationMenuItem {
    
    public var displayTitle: String
    public var storyboardId: String
    
    public init(displayTitle: String, storyboardId: String) {
        self.displayTitle = displayTitle
        self.storyboardId = storyboardId
    }
}

//
//  StoryBoard.swift
//  NavigationDrawerTest
//
//  Created by Rayhan Janam on 6/26/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import UIKit
import RNNavigationDrawerController

class Storyboard: RNStoryboardDelegate {
    
    var storyboard: UIStoryboard
    
    init() {
        storyboard = UIStoryboard(name: MainStoryBoardName, bundle: Bundle.main)
    }
    
    func getNavigationPanelController() -> RNNavigationPanelController? {
        return storyboard.instantiateViewController(withIdentifier: ViewControllers.navigationPanelControllerId) as? RNNavigationPanelController
    }
    
    func getChildViewController(withIdentifier identifier: String) -> RNChildViewController? {
        return storyboard.instantiateViewController(withIdentifier: identifier) as? RNChildViewController
    }
    
}

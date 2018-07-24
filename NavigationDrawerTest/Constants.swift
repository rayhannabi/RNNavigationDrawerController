//
//  Constants.swift
//  NavigationDrawerTest
//
//  Created by Rayhan Janam on 6/24/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import Foundation
import RNNavigationDrawerController

struct ViewControllers {
    
    static let navigationPanelControllerId = "NavigationPanelController"
    
    static let firstViewControllerId = "FirstViewController"
    static let secondViewControllerId = "SecondViewController"
    static let thirdViewControllerId = "ThirdViewController"
    static let fourthViewControllerId = "FourthViewController"
}

let menuItems: [RNNavigationMenuItem] = [
    RNNavigationMenuItem(displayTitle: "First View", storyboardId: ViewControllers.firstViewControllerId),
    RNNavigationMenuItem(displayTitle: "Second View", storyboardId: ViewControllers.secondViewControllerId),
    RNNavigationMenuItem(displayTitle: "Third View", storyboardId: ViewControllers.thirdViewControllerId),
    RNNavigationMenuItem(displayTitle: "Fourth View", storyboardId: ViewControllers.fourthViewControllerId)
]

let MenuCellId = "MenuCell"
let MainStoryBoardName = "Main"

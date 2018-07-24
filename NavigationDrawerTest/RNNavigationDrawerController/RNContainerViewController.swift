//
//  RNContainerViewController.swift
//  NavigationDrawerTest
//
//  Created by Rayhan Janam on 6/24/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import UIKit



/// Provides Container for the view controllers
class RNContainerViewController: UIViewController {
    
    enum NavigationPanelState {
        case expanded
        case collapsed
    }
    
    var currentState: NavigationPanelState = .collapsed {
        didSet {
            shouldAddShadow(state: currentState)
        }
    }
    
    var navigationPanelController: RNNavigationPanelController?
    var childController: RNChildViewController?
    
    /// First view controller to be added as child when the container is loaded in to view.
    var firstChildViewController: RNChildViewController?
    
    /// Loads both the navigation panel and the child view controllers.
    var storyboardDelegate: RNStoryboardDelegate?
    
    var navController: UINavigationController?
    var shouldUseNavigationController: Bool = false
    
    let childOriginXOffset: CGFloat = 300.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstVC = self.firstChildViewController {
            shouldUseNavigationController = firstVC.shouldEmbedInNavigationController
            addToParent(child: firstVC, isFirst: true)
        }
    }
}

// MARK: - RNNavigationPanelControllerDelegate methods. Handles SidePanel tasks.

extension RNContainerViewController: RNNavigationPanelControllerDelegate {
    
    func didSelectItem(_ menuItem: RNNavigationMenuItem) {
        print(menuItem.storyBoardId)
        
        // let newChildController = UIStoryboard.getViewController(withIdentifier: menuItem.storyBoardId)
        
        if storyboardDelegate != nil {
            
            let newChildController = storyboardDelegate!.getChildViewController(withIdentifier: menuItem.storyBoardId)
            
            shouldUseNavigationController = newChildController!.shouldEmbedInNavigationController
            
            self.addToParent(child: newChildController, isFirst: false)
            toggleNavigationPanelController()
        }
    }
    
    func addToParent(child: RNChildViewController?, isFirst: Bool) {
        
        // Set delegate
        
        child?.delegate = self
        
        // clear view
        
        if childController != nil {
            if let vc = childController as? UIViewController {
                
                if navController != nil {
                    navController!.view.removeFromSuperview()
                    navController!.removeFromParentViewController()
                }
                
                vc.view.removeFromSuperview()
                vc.removeFromParentViewController()
                vc.didMove(toParentViewController: self)
            }
        }
        
        // add new child view
        
        if let vc = child as? UIViewController {
            
            if shouldUseNavigationController {
                
                navController = UINavigationController(rootViewController: vc)
                
                child!.setStyleForNavigationController?(navController!)
                
                addChildViewController(navController!)
                
                navController!.view.frame.origin.x = navController!.view.frame.width - childOriginXOffset
                view.addSubview(navController!.view)
                
                navController!.didMove(toParentViewController: self)
                
            } else {
                
                addChildViewController(vc)
                
                if !isFirst {
                    vc.view.frame.origin.x = vc.view.frame.width - childOriginXOffset
                }
                
                view.addSubview(vc.view)
                
                vc.didMove(toParentViewController: self)
            }
            
            childController = vc as? RNChildViewController
        }
        
    }
    
}

// MARK: - RNChildViewControllerDelegate methods. Controls SidePanel.

extension RNContainerViewController: RNChildViewControllerDelegate {
    
    func toggleNavigationPanelController() {
        
        print("SIDE MENU ACTION TRIGGERED")
        
        if storyboardDelegate != nil {
            
            if currentState == .collapsed {
                addSidePanelController()
            }
            
            animateSidePanel(currentState)
        }
    }
    
    func addSidePanelController() {
        
        if navigationPanelController == nil {
            var navPanel = storyboardDelegate!.getNavigationPanelController()
            navPanel?.delegate = self
            
            if let navPanelVC = navPanel as? UIViewController {
                addChildViewController(navPanelVC)
                view.insertSubview(navPanelVC.view, at: 0)
                
                navPanelVC.didMove(toParentViewController: self)
                navigationPanelController = navPanel
            }
        }
    }
    
    func animateSidePanel(_ state: NavigationPanelState) {
        
        if let childVC = childController as? UIViewController {
            
            if state == .collapsed {
                
                // expand
                
                self.currentState = .expanded
                // let position = childVC.view.frame.width - childOriginXOffset
                let position = childOriginXOffset
                
                if shouldUseNavigationController {
                    animateChildControllerXPosition(target: navController!.view, position: position, completion: nil)
                } else {
                    animateChildControllerXPosition(target: childVC.view, position: position, completion: nil)
                }
                
            } else {
                
                // collapse
                
                if shouldUseNavigationController {
                    
                    animateChildControllerXPosition(target: navController!.view, position: 0) { (_) in
                        
                        self.currentState = .collapsed
                        (self.navigationPanelController as! UIViewController).view.removeFromSuperview()
                        self.navigationPanelController = nil
                        
                    }
                    
                } else {
                    animateChildControllerXPosition(target: childVC.view, position: 0) { (_) in
                        
                        self.currentState = .collapsed
                        (self.navigationPanelController as! UIViewController).view.removeFromSuperview()
                        self.navigationPanelController = nil
                        
                    }
                }
                
            }
            
        }
        
    }
    
    func animateChildControllerXPosition(target: UIView, position: CGFloat, completion: ((Bool) -> Void)?) {
        
        var dampingRatio: CGFloat = 1.0
        
        if position > 0 {
            dampingRatio = 0.8
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: dampingRatio, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
            target.frame.origin.x = position
            
        }, completion: completion)
        
    }
    
    func shouldAddShadow(state: NavigationPanelState) {
        
        if let vc = childController as? UIViewController {
            switch (state) {
            case .expanded:
                
                if shouldUseNavigationController {
                    navController!.view.layer.shadowOpacity = 0.80
                } else {
                    
                    vc.view.layer.shadowOpacity = 0.80
                }
            case .collapsed:
                if shouldUseNavigationController {
                    navController!.view.layer.shadowOpacity = 0.80
                } else {
                    vc.view.layer.shadowOpacity = 0.0
                }
            }
        }
        
    }
    
}

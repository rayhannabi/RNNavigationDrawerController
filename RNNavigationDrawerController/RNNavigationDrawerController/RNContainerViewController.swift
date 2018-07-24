//
//  RNContainerViewController.swift
//  RNNavigationDrawerController
//
//  Created by Rayhan Janam on 6/26/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import UIKit

public class RNContainerViewController: UIViewController {
    
    enum NavigationPanelState {
        case collapsed
        case expanded
    }
    
    var currentState: NavigationPanelState = .collapsed {
        didSet {
            self.shouldAddShadow(currentState)
        }
    }

    private var childNavigationController: UINavigationController?
    private var navigationPanelController: RNNavigationPanelController?
    private var currentChildController: RNChildViewController?
    
    public var firstChildController: RNChildViewController?
    public var storyboardDelegate: RNStoryboardDelegate?
    
    private var shouldUseDefaultNavigationController: Bool = true
    private let childOriginXOffset: CGFloat = 295.0
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        if let firstViewController = self.firstChildController {
            self.shouldUseDefaultNavigationController = firstViewController.shouldEmbedInNavigationController
            self.addToParent(child: firstViewController, isFirst: true)
        }
    }
}

extension RNContainerViewController: RNNavigationPanelControllerDelegate {
    
    public func didSelect(menuItem: RNNavigationMenuItem) {
        
        if let storyboardDelegate = self.storyboardDelegate,
            let newChildController = storyboardDelegate.getChildViewController(withIdentifier: menuItem.storyboardId) {
            self.shouldUseDefaultNavigationController = newChildController.shouldEmbedInNavigationController
            self.addToParent(child: newChildController, isFirst: false)
            
            self.toggleNavigationPanel()
        }
        
    }
    
    private func addToParent(child: RNChildViewController?, isFirst: Bool) {
        child?.delegate = self
        
        if currentChildController != nil,
            let existingViewController = currentChildController as? UIViewController {
            
            if self.childNavigationController != nil {
                self.childNavigationController!.view.removeFromSuperview()
                self.childNavigationController!.removeFromParentViewController()
                self.childNavigationController!.didMove(toParentViewController: self)
            }
            
            existingViewController.view.removeFromSuperview()
            existingViewController.removeFromParentViewController()
            existingViewController.didMove(toParentViewController: self)
        }
        
        if let newViewController = child as? UIViewController {
            
            if self.shouldUseDefaultNavigationController {
                self.childNavigationController = UINavigationController(rootViewController: newViewController)
                child!.setStyle?(for: self.childNavigationController!)
                
                self.addChildViewController(self.childNavigationController!)
                
                if !isFirst {
                    self.childNavigationController!.view.frame.origin.x = self.childNavigationController!.view.frame.width - self.childOriginXOffset
                }
                
                self.view.addSubview(self.childNavigationController!.view)
                self.childNavigationController?.didMove(toParentViewController: self)
            } else {
                self.addChildViewController(newViewController)
                
                if !isFirst {
                    newViewController.view.frame.origin.x = newViewController.view.frame.width - self.childOriginXOffset
                }
                
                self.view.addSubview(newViewController.view)
                newViewController.didMove(toParentViewController: self)
            }
            
            self.currentChildController = newViewController as? RNChildViewController
        }
    }
    
}



extension RNContainerViewController: RNChildViewControllerDelegate {
    
    public func toggleNavigationPanel() {
        
        if self.storyboardDelegate != nil {
            if self.currentState == .collapsed {
                addNavigationPanelController()
            }
            
            animateNavigationPanel(self.currentState)
        }
        
    }
    
    private func addNavigationPanelController() {
        
        if self.navigationPanelController == nil {
            var navigationPanel = storyboardDelegate!.getNavigationPanelController()
            navigationPanel?.delegate = self
            
            if let navPanelController = navigationPanel as? UIViewController {
                self.addChildViewController(navPanelController)
                self.view.insertSubview(navPanelController.view, at: 0)
                
                navPanelController.didMove(toParentViewController: self)
                self.navigationPanelController = navPanelController as? RNNavigationPanelController
            }
        }
        
    }
    
    private func animateNavigationPanel(_ state: NavigationPanelState) {
        
        if let childViewController = self.currentChildController as? UIViewController {
            switch (state) {
            case .collapsed:
                self.currentState = .expanded
                
                if self.shouldUseDefaultNavigationController {
                    animateChildPosition(target: self.childNavigationController!.view, position: self.childOriginXOffset, completion: nil)
                } else {
                    animateChildPosition(target: childViewController.view, position: childOriginXOffset, completion: nil)
                }
                
            case .expanded:
                if self.shouldUseDefaultNavigationController {
                    animateChildPosition(target: self.childNavigationController!.view, position: 0) { (_) in
                        self.currentState = .collapsed
                        (self.navigationPanelController as! UIViewController).view.removeFromSuperview()
                        self.navigationPanelController = nil
                    }
                } else {
                    animateChildPosition(target: childViewController.view, position: 0) { (_) in
                        self.currentState = .collapsed
                        (self.navigationPanelController as! UIViewController).view.removeFromSuperview()
                        self.navigationPanelController = nil
                    }
                }
            }
        }
        
    }
    
    private func animateChildPosition(target: UIView, position: CGFloat, completion: ((Bool) -> Void)?) {
        
        var dampingRatio: CGFloat = 1.0
        
        if position > 0 {
            dampingRatio = 0.8
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: dampingRatio, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            
            target.frame.origin.x = position
            
        }, completion: completion)
        
    }
    
    private func shouldAddShadow(_ state: NavigationPanelState) {
        
        let shadowOpacity: Float = 0.8
        
        if let viewController = self.currentChildController as? UIViewController {
            switch (state) {
            case .expanded:
                if self.shouldUseDefaultNavigationController {
                    self.childNavigationController!.view.layer.shadowOpacity = shadowOpacity
                } else {
                    viewController.view.layer.shadowOpacity = shadowOpacity
                }
                
            case .collapsed:
                if self.shouldUseDefaultNavigationController {
                    self.childNavigationController!.view.layer.shadowOpacity = 0.0
                } else {
                    viewController.view.layer.shadowOpacity = 0.0
                }
            }
        }
        
    }
    
}





















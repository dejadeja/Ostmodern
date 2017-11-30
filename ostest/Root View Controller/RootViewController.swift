//
//  RootViewController.swift
//  ostest
//
//  Created by Deja Cespedes on 30/11/2017.
//  Copyright © 2017 Maninder Soor. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    //MARK: - Properties
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        return view
    }()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loadingView)
        self.view.addSubview(errorView)
        
        self.loadingView.isHidden = false
        self.errorView.isHidden = true
        
        constrainViewToEdges(childView: loadingView)
        constrainViewToEdges(childView: errorView)
        
        initaliseDataSource()
    }
    
    //MARK: - Set up constraints
    private func constrainViewToEdges(childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        childView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        childView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        childView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    //MARK: - Set Up datasource
    private func initaliseDataSource() {
        //TODO: - Take from realm
        
        
        
    }
    
    //MARK: - Present Set ViewController
    private func presentSetViewController() {
        guard let navigationController = UIStoryboard(name: "Set", bundle: nil).instantiateInitialViewController() as? UINavigationController else {
            return
        }
        
        self.present(navigationController, animated: true, completion: nil)
    }
}

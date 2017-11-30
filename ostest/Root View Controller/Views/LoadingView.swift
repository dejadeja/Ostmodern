//
//  LoadingView.swift
//  ostest
//
//  Created by Deja Cespedes on 30/11/2017.
//  Copyright © 2017 Maninder Soor. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {
    //MARK: - Properties
    private lazy var loadingActivityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private lazy var loadingTextLabel: UILabel = {
        let label = UILabel()
        label.text = "LOADING..."
        label.font = UIFont(name: "CalibreWeb-Light", size: 8.0)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    //MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.3241378069, green: 0.4331541359, blue: 0.4794312716, alpha: 1)
        self.addSubview(loadingActivityIndicatorView)
        self.addSubview(loadingTextLabel)
        constrainViewsToCenter(activityIndicator: loadingActivityIndicatorView, label: loadingTextLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Constrain Subviews
    private func constrainViewsToCenter(activityIndicator: UIActivityIndicatorView, label: UILabel) {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 25.0).isActive = true
    }
}

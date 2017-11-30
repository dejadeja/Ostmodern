//
//  ErrorView.swift
//  ostest
//
//  Created by Deja Cespedes on 30/11/2017.
//  Copyright © 2017 Maninder Soor. All rights reserved.
//

import Foundation
import UIKit

class ErrorView: UIView {
    //MARK: - Properties
    private lazy var errorTextLabel: UILabel = {
        let label = UILabel()
        label.text = "An error has occured, please try again."
        label.font = UIFont(name: "CalibreWeb-Light", size: 11.0)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    //MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.3241378069, green: 0.4331541359, blue: 0.4794312716, alpha: 1)
        self.addSubview(errorTextLabel)
        constrainViewsToCenter(label: errorTextLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Constrain Subviews
    private func constrainViewsToCenter(label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

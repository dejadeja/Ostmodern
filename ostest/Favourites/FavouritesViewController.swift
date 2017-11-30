
//
//  FavouritesViewController.swift
//  ostest
//
//  Created by Deja Cespedes on 30/11/2017.
//  Copyright © 2017 Maninder Soor. All rights reserved.
//

import Foundation
import UIKit

class FavouritesViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var favouritesTableView: UITableView? {
        didSet {
            favouritesTableView?.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        }
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension FavouritesViewController: UITableViewDelegate {
    
}

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

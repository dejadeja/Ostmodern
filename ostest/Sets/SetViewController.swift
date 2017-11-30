//
//  SetViewController.swift
//  ostest
//
//  Created by Maninder Soor on 28/02/2017.
//  Copyright © 2017 Maninder Soor. All rights reserved.
//

import Foundation
import AlamofireImage
import RealmSwift
import SwiftyBeaver

/**
 Shows the list of Sets
 */
// Shows the list of Sets
final class SetViewController : UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var tblView : UITableView? {
        didSet {
            tblView?.register( UINib(nibName: "SetViewCell", bundle: nil), forCellReuseIdentifier: NSStringFromClass(SetViewCell.self))
            tblView?.delegate = self
            tblView?.dataSource = self
        }
    }
    
    @IBOutlet private weak var activity : UIActivityIndicatorView?
    
    //MARK: - Properties
    let log = SwiftyBeaver.self
    fileprivate var dataSource: RealmSetDataSource!
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setupLoading(isLoading: false)
        self.setupData()
    }
    
    //MARK: - Loading...
    private func setupLoading (isLoading : Bool) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: {
            self.activity?.alpha = isLoading ? 1.0 : 0.0
            self.tblView?.alpha = isLoading ? 0.0 : 1.0
        }) { (_) in }
    }
    
    //MARK: - Initialise DataSource
    
    /// Set's up the data for the table view
    public func setupData () {
        let data : Results<Movie> = Database.getSetData()
        dataSource = RealmSetDataSource(movies: data)
        tblView?.reloadData()
    }
}

///MARK: - UITableViewDataSource Implementation
extension SetViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(SetViewCell.self)) as? SetViewCell else {
            return UITableViewCell()
        }
        
        cell.lblTitle?.text = dataSource.titleOfMovie(atIndex: indexPath.row)
        cell.txtDescription?.text = dataSource.summaryOfMovie(atIndex: indexPath.row)
        
        if let imageURL = dataSource.imageURLForMovie(atIndex: indexPath.row) {
            DispatchQueue.main.async {
                cell.imgBackground?.af_setImage(withURL: imageURL)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
}

///MARK: - UITableViewDelegate Implementation
extension SetViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let navigationController = UIStoryboard(name: "SetDetail", bundle: nil).instantiateInitialViewController() as? UINavigationController,
            let setInformationViewController = navigationController.viewControllers.first as? SetDetailViewController else {
                return
        }
        
        guard let selectedSet = dataSource.episodeInformation(atIndex: indexPath.row) else {
            return
        }
        
        let selectedSetViewModel = SetDetailDataSource(setDetail: selectedSet)
        setInformationViewController.setDetailDataSource = selectedSetViewModel
        self.present(navigationController, animated: true, completion: nil)
    }
}

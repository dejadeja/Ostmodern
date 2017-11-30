//
//  Database.swift
//  ostest
//
//  Created by Maninder Soor on 28/02/2017.
//  Copyright © 2017 Maninder Soor. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyBeaver

/**
 The Database class manages DB access including convenint methods for inserts, deletions and updates
 */
class Database {
    
    /// Static Singleton
    static let instance = Database()
    
    /// Log
    let log = SwiftyBeaver.self
    
    //MARK: - Save movie sets to Realm
    static func saveSetData(movieSet: [Movie]) {
        movieSet.forEach { set in
            let realm = try! Realm()
            try! realm.write {
                realm.add(set)
            }
        }
    }
    
    //MARK: - Get items from Realm
    static func getSetData() -> Results<Movie> {
        let realm = try! Realm()
        let items = realm.objects(Movie.self)
        return items
    }
}

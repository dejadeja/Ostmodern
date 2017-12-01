//
//  API.swift
//  ostest
//
//  Created by Maninder Soor on 28/02/2017.
//  Copyright © 2017 Maninder Soor. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftyBeaver


///An enum of the possible set types which can come back from our response.
enum BaseSetType: String {
    case Home
    case Listings
    case Bundles
    case Collections
}

/**
 The API Class connects to the Skylark API to access content and present it type safe structs
 */
class API {
    /// Singleton instance
    static let instance = API()
    
    /// Log
    let log = SwiftyBeaver.self
    
    ///Temp debugger flag
    static let debug = true
    static let defaultSetType = BaseSetType.Collections
    
    ///Single set callback
    public typealias apiSetCallback = ((_ isSuccess : Bool, _ set : APISet?) -> Void)
    
    ///Multiple set callback
    public typealias apiSetsCallback = ((_ isSuccess : Bool, _ set : [APISet]?) -> Void)
    
    ///API Class constants
    public struct Consts {
        static let baseURL = API.debug == true ? "http://feature-code-test.skylark-cms.qa.aws.ostmodern.co.uk:8000" : "http://featore-code-test.skylurk-cms.qa.aws.ostmodern.co.uk:8080"
    }
    
    /**
     Get sets
     */
    func getSets (completion : @escaping apiSetsCallback) {
        let apiString = "\(Consts.baseURL)/api/sets/"
        log.verbose("Getting sets with URL \(apiString)")
        
        /// Request
        Alamofire.request(apiString).responseJSON { [weak self] response in
            self?.log.verbose("Response for getting sets \(response.response.debugDescription)")
            
            guard let response = response.result.value else {
                completion(false, nil)
                return
            }
            
            let json = JSON(response)
            let apiSet = self?.parseSetJSON(json: json)
            
            guard apiSet != nil else {
                completion(false, nil)
                return
            }
            
            self?.updateSets(apiSets: apiSet!)
            //parseSetToRealmObject(apiSet: apiSet)
            completion(true, apiSet)
        }
    }
    
    /**
     Updates an APISet object from the /sets/ endpoint to a full formed APISet with correct images
     
     - parameter set: The APISet to convert
     - returns: APISet
     */
    func updateSet(set: APISet, completion: @escaping apiSetCallback) {
        guard let apiString = set.imageURLs.first else {
            return
        }
        
        log.verbose("Getting image information with URL \(apiString)")
        
        /// Request
        Alamofire.request("\(Consts.baseURL)\(apiString)").responseJSON { response in
            self.log.verbose("Response for getting set image \(response.response.debugDescription)")
            
            if let result = response.result.value {
                let json = JSON(result)
                guard let url = json["url"].string else {
                    completion(false, nil)
                    return
                }
                
                let newSet = APISet(uid: set.uid, title: set.title, setDescription: set.setDescription, setDescriptionFormatted: set.setDescriptionFormatted, summary: set.summary, imageURLs: [url])
                completion(true, newSet)
                
            } else {
                completion(false, nil)
            }
        }
    }
    
    //MARK: - Parse set data
    private func parseSetJSON(json: JSON) -> [APISet]? {
        guard let setArray = APISet.parse(json) else {
            return nil
        }
        
        return setArray
    }
    
    
    private func parseSetToRealmObject(apiSet: APISet) {
        var movies: [Movie] = []
        
        //apiSet.forEach { set in
            let movie = Movie.initMovie(from: apiSet)
            movies.append(movie)
        //}
        
        Database.saveSetData(movieSet: movies)
    }
    
    private func updateSets(apiSets: [APISet]) {
        var sets: [APISet] = []
        
        apiSets.forEach { set in
            updateSet(set: set, completion: { (success, currentSet) in
                guard
                    success == true,
                    currentSet != nil else {
                        return
                }
                
                sets.append(currentSet!)
                self.parseSetToRealmObject(apiSet: currentSet!)
            })
        }
    }
}

extension API {
    /// Gets a set for a given type.
    func getSet(forName name: BaseSetType = API.defaultSetType, completion: @escaping apiSetCallback) {
        var selectedSet: [APISet]?
        
        getSets { (success, sets) in
            guard
                success == true,
                sets != nil else {
                    return
            }
            
            selectedSet = sets?.filter { $0.title == name.rawValue }
            
            guard let _ = selectedSet?.first else {
                completion(false, nil)
                return
            }
            
            // completion(true, )
        }
        
        //completion(nil)
    }
}

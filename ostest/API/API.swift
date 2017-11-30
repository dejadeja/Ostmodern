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
    static let defaultSetType = BaseSetType.Home

    ///API Class constants
    fileprivate struct Consts {
        static let baseURL = API.debug == true ? "http://feature-code-test.skylark-cms.qa.aws.ostmodern.co.uk:8000" : "http://featore-code-test.skylurk-cms.qa.aws.ostmodern.co.uk:8080"
    }
    
    /**
     Get sets
     */
    func getSets (completion : @escaping (_ isSuccess : Bool, _ set : [APISet]?) -> Void) {
        
        let apiString = "\(Consts.baseURL)/api/sets/"
        log.verbose("Getting sets with URL \(apiString)")
        
        /// Request
        Alamofire.request(apiString).responseJSON { response in
            
            self.log.verbose("Response for getting sets \(response.response.debugDescription)")
            
            if let _ = response.result.value {
                completion(false, nil)
            }
        }
    }
    
    /**
     Updates an APISet object from the /sets/ endpoint to a full formed APISet with correct images
     
     - parameter set: The APISet to convert
     - returns: APISet
     */
    func updateSet (set : APISet, completion : @escaping (_ isSuccess : Bool, _ set : APISet?) -> Void) {
        
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
}


extension API {
    /// Gets a set for a given type.
    func getSet(forName name: BaseSetType = API.defaultSetType, fromSets sets: [APISet]) -> APISet? {
        let selectedSet = sets.filter {
                $0.title == name.rawValue
        }

        return selectedSet.first
    }
}

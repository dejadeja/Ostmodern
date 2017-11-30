//
//  SetDetailDataSource.swift
//  ostest
//
//  Created by Deja Cespedes on 30/11/2017.
//  Copyright © 2017 Maninder Soor. All rights reserved.
//

import Foundation
import RealmSwift

class SetDetailDataSource {
    //MARK: - Properties
    fileprivate var setInformation: SetDetail?
    
    //MARK: - Initialiser
    init(setDetail: SetDetail) {
        self.setInformation = setDetail
    }
}

//MARK: - Retrieve functions
extension SetDetailDataSource {
    public func episodeTitle() -> String? {
        return setInformation?.episodeTitle
    }
    
    public func episodeDescription() -> String? {
        return setInformation?.episodeDescription
    }
}

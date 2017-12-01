//
//  SetDetail.swift
//  ostest
//
//  Created by Deja Cespedes on 30/11/2017.
//  Copyright © 2017 Maninder Soor. All rights reserved.
//

import Foundation

class SetDetail {
    //MARK: - Properties
    public var episodeTitle: String?
    public var episodeDescription: String?
    public var episodeImageURL: String?
    
    //MARK: - Initialiser
    init(title: String, description: String, imageURL: String) {
        self.episodeTitle = title
        self.episodeDescription = description
        self.episodeImageURL = imageURL
    }
}

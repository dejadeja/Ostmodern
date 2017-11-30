//
//  RealmSetDataSource.swift
//  ostest
//
//  Created by Deja Cespedes on 30/11/2017.
//  Copyright © 2017 Maninder Soor. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class RealmSetDataSource {
    //MARK: - Properties
    fileprivate var movies: Results<Movie>?
    
    //MARK: - Initialiser
    init(movies: Results<Movie>) {
        self.movies = movies
    }
}

//MARK: - Retrieve
extension RealmSetDataSource {
    public var numberOfMovies: Int {
        return movies!.count
    }
    
    public func titleOfMovie(atIndex index: Int) -> String? {
        return object(atIndex: index)?.title
    }
    
    public func descriptionForMovie(atIndex index: Int) -> String? {
        return object(atIndex: index)?.description
    }
    
    public func descriptionForMovieFormatted(atIndex index: Int) -> String? {
        return object(atIndex: index)?.setDescriptionFormatted
    }
    
    public func summaryOfMovie(atIndex index: Int) -> String? {
        return object(atIndex: index)?.summary
    }
    
    public func imageURLForMovie(atIndex index: Int) -> URL? {
        guard
            let urlString = object(atIndex: index)?.imageURLs.first?.url,
            let imageURL = URL(string: urlString) else {
                return nil
        }
        return imageURL
    }
    
    /*public func episodeInformation(atIndex index: Int) -> SetInformation? {
        guard
            let setTitle = object(atIndex: index)?.title,
            let setDescription = object(atIndex: index)?.setDescription else {
                return nil
        }
        
        let setInformation: SetInformation = SetInformation(title: setTitle, description: setDescription)
        return setInformation
    }*/
    
    private func object(atIndex index: Int) -> Movie? {
        return movies?[index]
    }
}

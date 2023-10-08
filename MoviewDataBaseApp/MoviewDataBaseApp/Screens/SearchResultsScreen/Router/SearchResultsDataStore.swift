//
//  SearchResultsDataStore.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

protocol ISearchResultsDataStore {
    var movieDetails: [MovieDetails]? { get set }
    
}

final class DefaultSearchResultsDataStore: ISearchResultsDataStore {
    var movieDetails: [MovieDetails]?
}

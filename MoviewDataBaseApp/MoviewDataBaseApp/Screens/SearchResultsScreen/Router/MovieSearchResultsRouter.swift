//
//  MovieSearchResultsRouter.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

import Foundation

protocol ISearchResultsViewRoutingLogic {
    
}

protocol ISearchResultsDataPassing {
    var dataStore: ISearchResultsDataStore { get set }
}

final class SearchResultsViewRouter: ISearchResultsViewRoutingLogic, ISearchResultsDataPassing {
    

    // MARK: - Variables
    weak var viewController: SearchResultsViewController?
    var dataStore: ISearchResultsDataStore
    //
    init(dataStore: ISearchResultsDataStore) {
        self.dataStore = dataStore
    }
}

//    MARK: - Routing Methods

extension SearchResultsViewRouter {
    
    
}



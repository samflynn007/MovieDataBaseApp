//
//  Configurator.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

import Foundation

struct SearchResultsConfigurator {
    static func configureSearchResultsView(viewController: SearchResultsViewController) {
        let dataStore = DefaultSearchResultsDataStore()
        let router = SearchResultsViewRouter(dataStore: dataStore)
        router.viewController = viewController
        
        let presenter = SearchResultsViewPresenter(output: viewController)
        
        let interactorDependency = SearchResultsViewInteractor.Dependency(output: presenter)
        let interactor = SearchResultsViewInteractor(with: interactorDependency)
        
        viewController.output = interactor
        viewController.router = router
    }
}


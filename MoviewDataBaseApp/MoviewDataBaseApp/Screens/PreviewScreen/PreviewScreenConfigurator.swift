//
//  PreviewScreenConfigurator.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

import Foundation

struct PreviewScreenConfigurator {
    static func configureMoviesView(viewController: PreviewViewController) {
        let dataStore = DefaultPreviewScreenDataStore()
        let router = PreviewScreenViewRouter(dataStore: dataStore)
        router.viewController = viewController
        
        let presenter = PreviewScreenViewPresenter(output: viewController)
        
        let interactorDependency = PreviewScreenViewInteractor.Dependency(output: presenter)
        let interactor = PreviewScreenViewInteractor(with: interactorDependency)
        
        viewController.output = interactor
        viewController.router = router
    }
}

//
//  PreviewScreenInteractor.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

import Foundation

typealias IPreviewScreenViewInteractorInput  = IPreviewScreenViewControllerOutput
typealias IPreviewScreenViewInteractorOutput = IPreviewScreenPresenterInput

final class PreviewScreenViewInteractor {
    struct Dependency {
//        var worker: IMoviesViewWorker?
        var output: IPreviewScreenViewInteractorOutput?
    }
    
    // MARK: - Properties
//    private var worker: IMoviesViewWorker?
    private var output: IPreviewScreenViewInteractorOutput?
    
    init(with dependency: Dependency) {
//        worker = dependency.worker
        output = dependency.output
    }
}
// MARK: - Interactor Input
extension PreviewScreenViewInteractor: IPreviewScreenViewInteractorInput {
  

    
}

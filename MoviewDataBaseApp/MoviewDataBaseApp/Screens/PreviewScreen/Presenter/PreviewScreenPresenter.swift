//
//  PreviewScreenPresenter.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

import Foundation

protocol IPreviewScreenPresenterInput {
    
}


typealias IPreviewScreenPresenterOutput = IPreviewScreenViewControllerInput

final class PreviewScreenViewPresenter {
    // MARK: Properties
    private weak var output: IPreviewScreenPresenterOutput?
    
    init(output: IPreviewScreenPresenterOutput) {
        self.output = output
    }
}

extension PreviewScreenViewPresenter: IPreviewScreenPresenterInput {
    
}




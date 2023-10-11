//
//  HomeViewControllerTest.swift
//  MoviewDataBaseAppTests
//
//  Created by Venky on 10/10/23.
//

import XCTest

@testable import MoviewDataBaseApp

final class HomeViewControllerTest: XCTestCase {
    
    private var viewController: MoviesViewController?
    private var interactor: HomeInteractorSpy?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = MoviesViewController.instance(.main) as? MoviesViewController
        interactor = HomeInteractorSpy()
        viewController?.output = interactor
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        interactor = nil
    }

    func testDataFetchAtViewLoadShouldCallFetchAPI() {
        XCTAssertEqual(viewController?.isViewLoaded, false)
        XCTAssertEqual(interactor?.didCallFetchData, false)
        viewController?.loadView()
        viewController?.viewDidLoad()
        XCTAssertEqual(viewController?.isViewLoaded, true)
        XCTAssertEqual(interactor?.didCallFetchData, true)
    }
    func testDataFetchAtViewLoadShouldCallSectionData() {
        XCTAssertEqual(viewController?.isViewLoaded, false)
        XCTAssertEqual(interactor?.didCallSectionData, false)
        viewController?.loadView()
        viewController?.viewDidLoad()
        XCTAssertEqual(viewController?.isViewLoaded, true)
        XCTAssertEqual(interactor?.didCallSectionData, true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
private final class HomeInteractorSpy: IMoviesViewControllerOutput {
    
    private(set) var didCallFetchData = false
    private(set) var didCallSectionData = false
    private(set) var didFetchSearchData = false
    
    func fetchMoviesData() {
        didCallFetchData = true
    }
    
    func fetchSectionData() {
        didCallSectionData = true
    }
    
    func fetchSearchData(_ movies: [MoviewDataBaseApp.MovieDetails], query: String) {
        didFetchSearchData = true
    }
    
    
    
    
}

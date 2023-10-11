//
//  HomePresenterTest.swift
//  MoviewDataBaseAppTests
//
//  Created by Venky on 10/10/23.
//

import XCTest
@testable import MoviewDataBaseApp

final class HomePresenterTest: XCTestCase {
    
    private var presenter: MoviesViewPresenter?
    private var viewController: HomeViewControllerSpy?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = HomeViewControllerSpy()
        presenter = MoviesViewPresenter(output: viewController!)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        viewController = nil
       
    }

    func testPresentDataAtMethodCallShouldCallDisplayForView() {
        XCTAssertEqual(viewController?.diddisplayMovieList, false)
//        XCTAssertEqual(viewController?.diddisplaySectionList, false)
        let mockResponse = [MovieDetails(Title: "")]
        presenter?.presentMoviesData(movieResponse: mockResponse)
        XCTAssertEqual(viewController?.diddisplayMovieList, true)
    }
    func testPresentDataAtMethodCallShouldCallDisplayForSection() {
        XCTAssertEqual(viewController?.diddisplaySectionList, false)
        let mockResponse = [MovieDetails(Title: "")]
        presenter?.updateAllSection(mockResponse)
        XCTAssertEqual(viewController?.diddisplaySectionList, true)
    }
    
    func testPresentDataAtMethodCallShouldCallDisplayForSearch() {
        XCTAssertEqual(viewController?.diddisplaySearch, false)
        let mockResponse = [MovieDetails(Title: "")]
        presenter?.presentSearchData(mockResponse)
        XCTAssertEqual(viewController?.diddisplaySearch, true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

private final class HomeViewControllerSpy: IMoviesViewPresenterOutput {
    
    private(set) var diddisplayMovieList = false
    private(set) var diddisplaySectionList = false
    private(set) var diddisplaySearch = false
    
    
    func displayMovieList(movieDetails: [MoviewDataBaseApp.MovieDetails]) {
        diddisplayMovieList = true
    }
    
    func displaySectionList(sectionMoview: [MoviewDataBaseApp.Section<Any>]) {
        diddisplaySectionList = true
    }
    
    func displaySearch(filteredMovies: [MoviewDataBaseApp.MovieDetails]) {
        diddisplaySearch = true
    }
    
}

//
//  HomeViewModelTests.swift
//  NinjaOneProjectTests
//
//  Created by Renato Mateus on 14/09/22.
//

import XCTest

@testable import NinjaOneProject

class HomeViewModelTests: XCTestCase {
    
    typealias Completion<T> = ((_ value: T) -> Void)
    var viewModel: HomeViewModel!
    var successCompletion: Completion<Any>!
    var failureCompletion: Completion<Any>!
    lazy var serviceMockSuccess: NinjaRepositoryMockSuccess = NinjaRepositoryMockSuccess()
    lazy var serviceMockFailure: NinjaRepositoryMockFailure = NinjaRepositoryMockFailure()
    
    let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
    func testFetchIfSuccess() {
        viewModel = HomeViewModel(with: serviceMockSuccess, coordinator: homeCoordinator)
        viewModel.monsters.bind { [unowned self] (_) in
            if let weather = self.viewModel.monsters.value {
                self.successCompletion(weather)
            }
        }
        let expectation = XCTestExpectation.init(description: "Creatures Data")
        self.successCompletion = { posts in
            XCTAssertNotNil(posts, .localized(.noDataDownloaded))
            expectation.fulfill()
        }
        viewModel.fetchData(0)
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testFetchPostsIfFailure() {
        viewModel = HomeViewModel(with: serviceMockFailure, coordinator: homeCoordinator)
        viewModel.error.bind { [unowned self] (_) in
            if let error = self.viewModel.error.value {
                failureCompletion(error)
            }
        }
        let expectation = XCTestExpectation.init(description: "Error")
        self.failureCompletion = { error in
            XCTAssertNotNil(error, .localized(.noDataDownloaded))
            expectation.fulfill()
        }
        viewModel.fetchData(0)
        wait(for: [expectation], timeout: 60.0)
    }
}

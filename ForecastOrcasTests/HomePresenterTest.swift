//
//  HomePresenterTest.swift
//  ForecastOrcasTests
//
//  Created by mohamed hashem on 20/02/2021.
//

import XCTest
@testable import ForecastOrcas

class HomePresenterTest: XCTestCase {
    
    func testVoidFunction() {

        let eventSection = ForecastOrcas(360630)
        let weatherError = ForecastError.cityName
        let viewController = HomeViewControllerTest()
        let presenter = HomePresenter()

        // configure protocols
        presenter.output = viewController
        presenter.present(section: eventSection)
        presenter.present(errorStories: weatherError, cityName: "")

        //test equalization
        XCTAssertEqual(viewController.presentSections, true)
        XCTAssertEqual(viewController.presentError, true)
        //XCTAssertEqual(viewController.presentErrorWithData, true)
    }
}

extension HomePresenterTest {

    // just for test error
    enum ForecastError: Error {
        case cachedWeather
        case cityName
    }
}

//
//  HomeViewControllerTests.swift
//  ForecastOrcasTests
//
//  Created by mohamed hashem on 20/02/2021.
//

import XCTest
@testable import ForecastOrcas

 class HomeViewControllerTest: HomeViewControllerInput {
    var presentSections = false
    var presentError = false
    var presentErrorWithData = false

    //output protocol, not all functions have done, just first one
    func display(section: WeatherModel) {
        presentSections = true
    }

    func display(error: Error, cachedSection: WeatherModel) {
        presentErrorWithData = true
    }

    func display(error: Error) {
        presentError = true
    }
}

extension HomeViewControllerTest: HomePresenterOutput {

    func present(section: WeatherModel) { }
    
    func present(error: Error, cachedSection: WeatherModel) { }

    func present(error: Error) { }
}

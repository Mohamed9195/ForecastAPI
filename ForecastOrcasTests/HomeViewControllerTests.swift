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

    func display(errorStories: Error, cachedSection: WeatherModel?) {
        let cachedWether: WeatherModel? = nil
        //let cachedWether: WeatherModel? = WeatherModel()
        cachedWether == nil ? (presentError = true) : (presentErrorWithData = true)
    }
}

extension HomeViewControllerTest: HomePresenterOutput {
    func present(section: ForecastOrcas) {
    }

    func present(errorStories: Error, cityName: String) {
    }
}

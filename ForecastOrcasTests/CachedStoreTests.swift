//
//  CachedStoreTests.swift
//  ForecastOrcasTests
//
//  Created by mohamed hashem on 20/02/2021.
//

import XCTest
@testable import ForecastOrcas

class CachedStoreTests: XCTestCase {

    var expectedWeatherTypeEventsResponse: WeatherModelType!
    var expectedWeatherEventsResponse: [WeatherModel]!
    

    func testWeatherType() {

        expectedWeatherTypeEventsResponse = WeatherModelType.new
      //  XCTAssertEqual(newWeather.hashValue, expectedWeatherTypeEventsResponse.hashValue)
    }

}


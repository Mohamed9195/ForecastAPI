//
//  ForecastOrcasTests.swift
//  ForecastOrcasTests
//
//  Created by mohamed hashem on 19/02/2021.
//

import XCTest
@testable import ForecastOrcas

class GetWeatherEventTests: XCTestCase {

    var expectedEventsResponse: ForecastOrcas!

    func testForecastOrcasJsonMapping() {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "WeatherEvent", ofType: "json") else {
            fatalError("WeatherEvent.json cannot be loaded")
        }

        // this based on the data from the json file
        expectedEventsResponse = ForecastOrcas(360630)

        guard let json = try? String(contentsOfFile: path) else { fatalError("Cannot load json file") }

        guard let jsonDecoderForecastOrcas = try? JSONDecoder().decode(ForecastOrcas.self,
                                                                             from: json.data(using: .utf8)!) else {
                                                                             fatalError("WeatherEvent is not found") }
        XCTAssertEqual(jsonDecoderForecastOrcas, expectedEventsResponse)
    }
}

// MARK: - Equatable.
extension ForecastOrcas: Equatable {
    public static func == (lhs: ForecastOrcas, rhs: ForecastOrcas) -> Bool {
        lhs.city?.id == rhs.city?.id
    }
}

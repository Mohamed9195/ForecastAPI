//
//  ForecastOrcasEndpointSpecifications.swift
//  ForecastOrcas
//
//  Created by mohamed hashem on 19/02/2021.
//

import Foundation
import Moya

// MARK: - Provider Specifications
enum ForecastOrcasEndpointSpecifications {
    
    case openWeatherMap(cityName: String, resultType: String, unitsType: String, numberOfDays: Int)
    case openWeatherMapByName(cityName: String)
}

// MARK: - Provider release url
let releaseURL = "http://api.openweathermap.org/data/2.5/forecast" // for three days
    // for one day "http://api.openweathermap.org/data/2.5/weather"
    // paid "http://api.openweathermap.org/data/2.5/forecast/daily"
let apiKey = "d5a8f62a930699c13acaf44231d51aa4"

// MARK: - Provider target type
extension ForecastOrcasEndpointSpecifications: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: releaseURL)!
        }
    }

    var path: String {
        switch self {
        case .openWeatherMap,
             .openWeatherMapByName:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .openWeatherMap,
             .openWeatherMapByName:
            return .get
        }
    }

    // header
    var headers: [String : String]? {
        switch self {
        case .openWeatherMap,
             .openWeatherMapByName:
            return  ["" : ""]
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)! as Data
    }

    var task: Task {
        switch self {

        // send request as by parameter as query
        case .openWeatherMap(let cityName, let resultType, let unitsType, let numberOfDays):
            let parameters: [String : Any] = ["q" : cityName,
                                              "mode" : resultType,
                                              "units" : unitsType,
                                              "cnt" : numberOfDays,
                                              "appid" : apiKey]

            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

        case .openWeatherMapByName(let cityName):
            let parameters: [String : Any] = ["q" : cityName,
                                              "appid" : apiKey]

            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

        }
    }
}

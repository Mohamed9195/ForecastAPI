//
//  ConstantStore.swift
//  ForecastOrcas
//
//  Created by mohamed hashem on 19/02/2021.
//

import Foundation
import RxSwift

class ConstantStore {

    static let sharedInstance = ConstantStore()

    enum Features: String {
        case orcasWeather
    }

    var AllWeatherMap: Data? {
        set {
            let encoder = JSONEncoder()
            let weatherData = try? encoder.encode(newValue)
            UserDefaults.standard.set(weatherData, forKey: Features.orcasWeather.rawValue)
            UserDefaults.standard.synchronize()
        }

        get {
            let weatherData = UserDefaults.standard.data(forKey: Features.orcasWeather.rawValue)
            return weatherData
        }
    }

    func getWeatherMap() -> [WeatherModel]? {
        if let weatherMapData = AllWeatherMap {
            // can using try? and return optional weather
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode([WeatherModel].self, from: weatherMapData)
                return weather
            } catch {
                print("Unable to Decode Notes (\(error))")
                return nil
            }
        } else {
            return nil
        }
    }

    func getWeatherModelType(weather: WeatherModel?) -> WeatherModelType {
        // just for test
        guard weather != nil,
              let lastWeatherCached = ConstantStore.sharedInstance.getWeatherMap(),
              !lastWeatherCached.isEmpty else { return .new }

        let cityIsFounded = lastWeatherCached.contains { weatherModel -> Bool in
            if weatherModel.sections.first?.cityName == weather?.sections.first?.cityName {
                return true
            } else {
                return false
            }
        }

        switch cityIsFounded {
        case true: return .cached
        case false: return .new
        }
    }

    func saveNewWeather(weather: WeatherModel, weatherType: WeatherModelType) {
        if weatherType == .new {
            if var lastWeatherCached =  ConstantStore.sharedInstance.getWeatherMap(),
               lastWeatherCached.count > 0 {
                lastWeatherCached.append(weather)
                let encoder = JSONEncoder()
                let weatherData = try? encoder.encode(lastWeatherCached)

                ConstantStore.sharedInstance.AllWeatherMap = weatherData

            } else {
                let encoder = JSONEncoder()
                let weatherData = try? encoder.encode(weather)

                ConstantStore.sharedInstance.AllWeatherMap = weatherData
            }
        }
    }
}

//
//  HomeInteractor.swift
//
//  Created by mohamed hashem on 19/02/2021.
//  Copyright (c) 2021 mohamed hashem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RxSwift

protocol HomeInteractorInput: class {
    func loadForecastOrcas(cityName: String, resultType: String, unitsType: String, numberOfDays: Int)
}

protocol HomeInteractorOutput: class {
    func present(section: ForecastOrcas)
    func present(error: Error, cachedSection: WeatherModel)
    func present(error: Error)
}

class HomeInteractor: HomeInteractorInput {

    var output: HomeInteractorOutput?
    let worker = HomeWorker()
    private let disposed = DisposeBag()
    private var cityName: String = ""

    func loadForecastOrcas(cityName: String, resultType: String, unitsType: String, numberOfDays: Int) {
        self.cityName = cityName
        ForecastOrcasEndPoints.shared
            .provider.rx
            .request(.openWeatherMapByName(cityName: cityName))
            .filterSuccessfulStatusCodes()
            .timeout(.seconds(30), scheduler: MainScheduler.instance)
            .retry(2)
            .map(ForecastOrcas.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { response in
                self.handlingLoadForecastOrcasSuccess(forecastOrcas: response)

            }) { error in
                self.handlingLoadForecastOrcasError(error)

            }.disposed(by: disposed)
    }

    private func handlingLoadForecastOrcasSuccess(forecastOrcas: ForecastOrcas) {
        output?.present(section: forecastOrcas)

        // check if weather was cached
        // weather cached
        let weatherModelType = ConstantStore.sharedInstance.getWeatherModelType(weather: forecastOrcas)
        switch weatherModelType {
        case .new:
            ConstantStore.sharedInstance.saveNewWeather(forecast: forecastOrcas, weatherType: .new)
        case .cached:
            break // in future replace old data by new data
        }
    }

    private func handlingLoadForecastOrcasError(_ error: Error) {
        guard let weather = ConstantStore.sharedInstance.getWeatherMap(),
              !weather.isEmpty else {
            self.output?.present(error: error)
            return
        }

        weather.forEach { weatherIs in
            if weatherIs.sections.first?.cityName == cityName {
                self.output?.present(error: error, cachedSection: weatherIs)
            } else {
                self.output?.present(error: error)
            }
        }
    }
}

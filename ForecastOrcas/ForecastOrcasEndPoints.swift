//
//  ForecastOrcasEndPoints.swift
//  ForecastOrcas
//
//  Created by mohamed hashem on 19/02/2021.
//

import Foundation
import Moya
import RxSwift

// MARK: - Provider support
final class ForecastOrcasEndPoints {

    static var shared = ForecastOrcasEndPoints()

    let provider = MoyaProvider<ForecastOrcasEndpointSpecifications>(plugins: [CompleteUrlLoggerPlugin()])
}

class CompleteUrlLoggerPlugin : PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        print("##URL", request.request?.url?.absoluteString ?? "Something is wrong","  ##Body", request.request?.httpBody ?? "Something is wrong", "  ##header", request.request?.headers as Any)
    }
}



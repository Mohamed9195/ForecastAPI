//
//  PKHUD.swift
//  ForecastOrcas
//
//  Created by mohamed hashem on 19/02/2021.
//

import PKHUD

class PKHUDIndicator {

    class func showProgressView() {
        HUD.hide(afterDelay: 30)
        HUD.show(.systemActivity)
    }

    class func hideProgressView() {
        HUD.hide()
    }

    class func hideBySuccessFlash() {
        HUD.flash(.success)
    }

    class func hideByErrorFlash() {
        HUD.flash(.error)
    }
}

//
//  ViewControllerExtension.swift
//  ForecastOrcas
//
//  Created by mohamed hashem on 20/02/2021.
//

import UIKit

extension UIViewController {

    func showWarningCustomToast(message : String? = "Something went wrong, please try again later") {
        
        let toastLabel = UILabel(frame: CGRect(x: (self.view.frame.size.width - 200) / 2, y: 100, width: 200, height: 35))
        toastLabel.backgroundColor = #colorLiteral(red: 1, green: 0.8549019608, blue: 0.1764705882, alpha: 0.8)
        toastLabel.textColor = .black
        toastLabel.font = UIFont(name: "AvenirNextLTPro-Demi", size: 15)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 2
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        toastLabel.frame.size.height = toastLabel.frame.size.height
        UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

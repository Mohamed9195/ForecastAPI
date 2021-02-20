//
//  CustomAlert.swift
//  ForecastOrcas
//
//  Created by mohamed hashem on 20/02/2021.
//

import UIKit
import SwiftMessages
import Moya

class PopUpAlert {

    let alert: UIAlertController

    init(title: String? = nil, message: String? = nil, type: UIAlertController.Style = .alert) {
        alert = UIAlertController(title: title, message: message, preferredStyle: type)
    }

    func add(action: UIAlertAction) -> Self {
        alert.addAction(action)
        return self
    }

    func addCancelAction(title: String = "Cancel") -> Self {
        alert.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        return self
    }

    func show(in vc: UIViewController? = nil) {
        if let vc = vc {
            vc.present(alert, animated: true, completion: nil)
        }
    }

    @discardableResult
    class func genericErrorAlert(error: String = "Something went wrong, please try again later") -> PopUpAlert {
        return PopUpAlert(
            title: "oops sorry",
            message: error
        ).addCancelAction(title: "Ok")
    }

    class func showErrorToastWith(message: String = "Something went wrong, please try again later", _ error: Error? = nil) {
        let messageView = MessageView.viewFromNib(layout: .cardView)

        messageView.button?.isHidden = true
        messageView.titleLabel?.isHidden = true
        messageView.configureContent(body: message)
        messageView.configureTheme(.error)

        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.ignoreDuplicates = false
        config.duration = .seconds(seconds: 2)
        DispatchQueue.main.async {
            SwiftMessages.show(config: config, view: messageView)
        }
    }
}

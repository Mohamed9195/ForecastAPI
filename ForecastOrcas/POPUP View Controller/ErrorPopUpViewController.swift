//
//  ErrorPopUpViewController.swift
//  ForecastOrcas
//
//  Created by mohamed hashem on 19/02/2021.
//

import UIKit

class ErrorPopUpViewController: UIViewController {

    @IBOutlet weak var errorMessageLabel: UILabel!

    var errorMessageIs: String?
    var reLoadForecastOrcas: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        errorMessageIs != nil ? (errorMessageLabel.text = errorMessageIs) : (errorMessageLabel.text = "some thing error happen, please try again later.")
    }
    
    @IBAction func reLoadForecastOrcas(_ sender: UIButton) {
        reLoadForecastOrcas?()
    }

    @IBAction func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

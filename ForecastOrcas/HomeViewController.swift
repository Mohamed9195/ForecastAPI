//
//  HomeViewController.swift
//
//  Created by mohamed hashem on 19/02/2021.
//  Copyright © 2021 mohamed hashem. All rights reserved.


import UIKit
import RxCocoa
import RxSwift

protocol HomeViewControllerInput: class {
    func display(section: WeatherModel)
    func display(error: Error, cachedSection: WeatherModel)
    func display(error: Error)
}

protocol HomeViewControllerOutput: class {
    func loadForecastOrcas(cityName: String, resultType: String, unitsType: String, numberOfDays: Int)
}

class HomeViewController: UIViewController {

    @IBOutlet weak var forecastOrcasTable: UITableView!
    @IBOutlet weak var forecastOrcasSearchBar: UISearchBar!
    @IBOutlet weak var warningLabel: UILabel!

    private let disposed = DisposeBag()
    var output: HomeViewControllerOutput?
    var router: HomeRouter!
    var errorMessageIs: String?
    private var loadingForecastOrcas = true
    private var weatherModelSections = WeatherModel()

    // MARK: View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        HomeConfiguration.sharedInstance.configure(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//MARK:- call api when search button in forecastOrcasSearchBar clicked
        forecastOrcasSearchBar
            .rx
            .searchButtonClicked
            .subscribe (onNext: { [weak self] _ in
                guard let self = self,
                      let cityName = self.forecastOrcasSearchBar.text else { return }

                PKHUDIndicator.showProgressView()
                self.output?.loadForecastOrcas(cityName: cityName,
                                               resultType: "json",
                                               unitsType: "units",
                                               numberOfDays: 1)
                self.forecastOrcasSearchBar.resignFirstResponder()

            }, onError: { error in
                print(error)
            }).disposed(by: disposed)

//MARK:- call api when text in forecastOrcasSearchBar change

//        forecastOrcasSearchBar
//            .rx
//            .text
//            .subscribe (onNext: { [weak self] searchBarText in
//                guard let self = self,
//                      let cityName = searchBarText else { return }
//
//                PKHUDIndicator.showProgressView()
//                self.output?.loadForecastOrcas(cityName: cityName,
//                                               resultType: "json",
//                                               unitsType: "units",
//                                               numberOfDays: 1)
//                self.forecastOrcasSearchBar.resignFirstResponder()
//
//            }, onError: { error in
//                print(error)
//            }).disposed(by: disposed)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.routeToSomewhere(segue: segue)
    }

    func reLoadForecastOrcas() {
        PKHUDIndicator.showProgressView()
        guard let cityName = self.forecastOrcasSearchBar.text else { return }

        self.output?.loadForecastOrcas(cityName: cityName,
                                       resultType: "json",
                                       unitsType: "units",
                                       numberOfDays: 1)
    }

}

//MARK:- protocol Home ViewController Input
extension HomeViewController: HomeViewControllerInput {

    func display(section: WeatherModel) {
        PKHUDIndicator.hideProgressView()

        loadingForecastOrcas = false
        warningLabel.isHidden = true

        weatherModelSections = section
        forecastOrcasTable.reloadData()
    }

    func display(error: Error, cachedSection: WeatherModel) {
        PKHUDIndicator.hideProgressView()
        PopUpAlert.showErrorToastWith(message: error.localizedDescription, error)

        loadingForecastOrcas = false
        warningLabel.isHidden = false

        self.showWarningCustomToast(message: warningLabel.text)
        weatherModelSections = cachedSection
        forecastOrcasTable.reloadData()
    }

    func display(error: Error) {
        PKHUDIndicator.hideProgressView()
        PopUpAlert.showErrorToastWith(message: error.localizedDescription, error)

        loadingForecastOrcas = false
        warningLabel.isHidden = true
        
        errorMessageIs = error.localizedDescription
        router.navigateBySegue(to: .errorPopUp)
    }
}

// MARK: - UISearch Controller view Delegate
extension HomeViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.weatherModelSections.sections = []
                self.forecastOrcasTable.reloadData()
            }
        } else {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.forecastOrcasSearchBar.text = ""
                self.weatherModelSections.sections = []
                self.forecastOrcasTable.reloadData()
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // output?.loadForecastOrcas(cityName: String, resultType: String, unitsType: String, numberOfDays: Int, key: String)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            // output?.loadForecastOrcas(cityName: String, resultType: String, unitsType: String, numberOfDays: Int, key: String)
        }
    }
}


//MARK:- table View
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return weatherModelSections.sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let titleForHeaderInSection = weatherModelSections.sections[section].HeaderTitle else {
            return "--/--/----"
        }
        return titleForHeaderInSection
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 8, y: 0, width: tableView.bounds.size.width - 8, height: 30))
        headerView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        let headerLabel = UILabel(frame: CGRect(x: 8, y: 0, width: tableView.bounds.size.width, height: 30))
        headerLabel.textColor = .black
        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        headerLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)

        if let titleForHeaderInSection = weatherModelSections.sections[section].HeaderTitle {
            headerLabel.text = titleForHeaderInSection
        } else {
            headerLabel.text = "--/--/----"
        }

        headerView.addSubview(headerLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch loadingForecastOrcas {
        case true:
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingOrderTableViewCell
            return cell

        case false:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackingDetailsCell", for: indexPath) as? OrderTrackingDetailsTableViewCell else {
                fatalError("no cell trackingDetailsCell")
            }
            cell.configurationUI(sectionWeather: weatherModelSections.sections[indexPath.row])

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

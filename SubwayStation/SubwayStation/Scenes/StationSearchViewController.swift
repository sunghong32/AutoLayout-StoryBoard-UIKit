//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by 민성홍 on 2022/06/29.
//

import UIKit
import SnapKit
import Alamofire

class StationSearchViewController: UIViewController {
    private var stations: [Station] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationItems()
        setTableViewLayout()
    }

    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"

        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
    }

    private func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    private func requestStationName(from stationName: String) {
        let urlString = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/\(stationName)"

        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationResponseModel.self) { [weak self] response in
                guard let self = self else { return }
                guard case .success(let data) = response.result else { return }

                self.stations = data.stations
                self.tableView.reloadData()
            }
            .resume()
    }
}

extension StationSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.reloadData()
        tableView.isHidden = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestStationName(from: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        stations = []
    }
}

extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row]
        let vc = StationDetailViewController(station: station)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var stationNameArr: [String] = []

        for i in 0..<stations.count {
            stationNameArr.append(stations[i].stationName)
        }

        let tempArr = Set(stationNameArr)
        stationNameArr = Array(tempArr)

        return stationNameArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let station = stations[indexPath.row]
        var lineStr: String = ""

        for i in 0..<stations.count {
            lineStr += stations[i].lineNumber
        }

        cell.textLabel?.text = station.stationName
        cell.detailTextLabel?.text = lineStr.replacingOccurrences(of: "0", with: "")
            .replacingOccurrences(of: "선", with: "선 ")

        return cell
    }
}

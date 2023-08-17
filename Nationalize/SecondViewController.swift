//
//  SecondViewController.swift
//  Nationalize
//
//  Created by Ilya Pogozhev on 17.08.2023.
//

import UIKit
import SnapKit

struct Welcome: Codable {
    let count: Int
    let name: String
    let country: [Country]
}
struct Country: Codable {
    let countryID: String
    let probability: Double

    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case probability
    }
}
class SecondViewController: UIViewController {
    var countries: [Country] = []
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupScene()
        makeConstraints()
    }
}
private extension SecondViewController {
    func setupScene() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
    }
    func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    func flag(from country: String) -> String {
        let base: UInt32 = 127397
        var s = ""
        for i in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + i.value)!)
        }
        return s
    }
}
extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = "\(flag(from: country.countryID)) \(country.countryID): \(String(format: "%.2f", country.probability * 100)) %"
        return cell
    }
    
    
}


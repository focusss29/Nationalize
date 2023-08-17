//
//  ViewController.swift
//  Nationalize
//
//  Created by Ilya Pogozhev on 17.08.2023.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    let textField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter name..."
        text.textAlignment = .center
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 25
        text.font = .preferredFont(forTextStyle: .headline)
        text.font = UIFont.systemFont(ofSize: 25)
        return text
    }()
    let buttonStart: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.setTitle("Predict the nationality", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonPredict), for: .touchUpInside)
        return button
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "Predict the nationality of a name"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        setupScene()
        makeConstraints()
    }
}
extension FirstViewController {
    func setupScene() {
        view.addSubview(textField)
        view.addSubview(buttonStart)
        view.addSubview(label)
    }
    func makeConstraints() {
        textField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(50)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(50)
        }
        buttonStart.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(50)
        }
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(75)
            $0.left.right.equalToSuperview().inset(25)
        }
    }
    @objc func buttonPredict() {
        let vc2 = SecondViewController()
        navigationController?.pushViewController(vc2, animated: true)
        vc2.navigationItem.title = textField.text
        if let url = URL(string: "https://api.nationalize.io/?name=\(textField.text ?? "")") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error \(error)")
                    return
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    if let decodedData = try? decoder.decode(Welcome.self, from: data) {
                        DispatchQueue.main.async {
                            vc2.countries = decodedData.country
                            vc2.tableView.reloadData()
                        }
                    }
                }
            }
            task.resume()
        }
    }
}



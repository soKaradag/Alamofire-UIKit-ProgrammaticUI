//
//  ViewController.swift
//  RickAndMortyAlamofire
//
//  Created by Serdar Onur KARADAĞ on 1.06.2023.
//

import UIKit

class HomeViewController: UIViewController {
    private let apiHandler = APIHandler()
    private var persons: [Person] = []

    private let homeViewTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeViewTable)
        
        self.title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        homeViewTable.dataSource = self
        homeViewTable.delegate = self
        
        homeViewTable.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)

        apiHandler.fetchData { [weak self] fetchedPersons, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            } else if let persons = fetchedPersons {
                self?.persons = persons
                DispatchQueue.main.async {
                    self?.homeViewTable.reloadData()
                }
            }
        }

        addConstraints()
    }

    private func addConstraints() {
        let tableViewConstraints = [
            homeViewTable.topAnchor.constraint(equalTo: view.topAnchor),
            homeViewTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeViewTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeViewTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(persons.count)
        return persons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: persons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

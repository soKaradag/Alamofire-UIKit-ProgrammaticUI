//
//  ViewController.swift
//  RickAndMortyAlamofire
//
//  Created by Serdar Onur KARADAĞ on 1.06.2023.
//

import UIKit

class HomeViewController: UIViewController {
    private let apiHandler = APIHandler()

    
    private let homeViewTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        homeViewTable.dataSource = self
        homeViewTable.delegate = self
        
        apiHandler.fetchData { fetchedPersons, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            } else if let persons = fetchedPersons {
                print(persons[0])
            }
        }

        
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}

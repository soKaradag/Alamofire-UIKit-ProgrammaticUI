//
//  ViewController.swift
//  RickAndMortyAlamofire
//
//  Created by Serdar Onur KARADAĞ on 1.06.2023.
//

import UIKit

class HomeViewController: UIViewController {
    var currentPage = 38
    
    private let apiHandler = APIHandler.shared
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
        
        performAPIRequest()

        addConstraints()
        configureNavBar()
    }
    
    func performAPIRequest() {
          guard let url = Constants.characterURL(forPage: currentPage) else {
              return
          }
          
          let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
              if let error = error {
                  print("Error: \(error.localizedDescription)")
                  return
              }
              
              if let data = data {
                  do {
                      let decoder = JSONDecoder()
                      let apiResponse = try decoder.decode(PersonResponse.self, from: data)
                      let fetchedPersons = apiResponse.results
                      
                      // Update the persons array with the fetched data
                      self?.persons = fetchedPersons
                      
                      DispatchQueue.main.async {
                          // Reload the table view with the updated data on the main queue
                          self?.homeViewTable.reloadData()
                      }
                  } catch {
                      print("Error decoding API response: \(error.localizedDescription)")
                  }
              }
          }
          
          task.resume()
      }
    
    @objc func previousButtonTapped() {
        if currentPage > 1 {
            currentPage -= 1
            performAPIRequest()
        }
    }
    
    @objc func nextButtonTapped() {
        currentPage += 1
        performAPIRequest()
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self , action: #selector(nextButtonTapped)),
            UIBarButtonItem(image: UIImage(systemName: "minus.circle"), style: .done, target: self , action: #selector(previousButtonTapped))
        ]
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
        let screenHeight = UIScreen.main.bounds.height
        let rowHeight = screenHeight * 0.1
        return rowHeight
    }

}

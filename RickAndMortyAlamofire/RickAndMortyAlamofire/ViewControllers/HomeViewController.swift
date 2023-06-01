//
//  ViewController.swift
//  RickAndMortyAlamofire
//
//  Created by Serdar Onur KARADAĞ on 1.06.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeViewTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }


}


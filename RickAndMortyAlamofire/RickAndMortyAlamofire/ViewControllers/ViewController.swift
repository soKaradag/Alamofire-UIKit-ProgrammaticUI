//
//  ViewController.swift
//  RickAndMortyAlamofire
//
//  Created by Serdar Onur KARADAĞ on 1.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var caller = APIHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        caller.fetchData()
    }


}


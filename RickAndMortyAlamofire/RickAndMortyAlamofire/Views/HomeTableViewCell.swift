//
//  HomeTableViewCell.swift
//  RickAndMortyAlamofire
//
//  Created by Serdar Onur KARADAĞ on 1.06.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    static let identifier = "HomeTableViewCell"
    
    private let heroName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .label
        return label
    }()
    
    private let heroGender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .label
        return label
    }()
    
    
    private let heroImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(heroName)
        contentView.addSubview(heroGender)
        contentView.addSubview(heroImage)
        
        addConstraints()
    }
    
    private func addConstraints() {
        let heroImageViewConstraints = [
            heroImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            heroImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heroImage.widthAnchor.constraint(equalToConstant: 100),
            heroImage.heightAnchor.constraint(equalToConstant: 100)
        ]
        let heroNameConstraints = [
            heroName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            heroName.leadingAnchor.constraint(equalTo: heroImage.trailingAnchor, constant: 20)
        ]
        let heroGenderConstraints = [
            heroGender.topAnchor.constraint(equalTo: heroName.bottomAnchor, constant: 20),
            heroGender.leadingAnchor.constraint(equalTo: heroImage.trailingAnchor, constant: 20)
        ]

        NSLayoutConstraint.activate(heroImageViewConstraints)
        NSLayoutConstraint.activate(heroNameConstraints)
        NSLayoutConstraint.activate(heroGenderConstraints)
    }
    
    func configure(with person: Person) {
        heroName.text = person.name
        heroGender.text = person.gender
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

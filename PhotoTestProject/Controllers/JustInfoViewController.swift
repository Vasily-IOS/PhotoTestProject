//
//  DeleteInfoViewController.swift
//  PhotoTestProject
//
//  Created by Василий on 24.01.2022.
//

import UIKit

final class JustInfoViewController: UIViewController {

// MARK: - properties

    let photoImage = UIImageView()
    let nameAuthorLabel = UILabel()
    let dateOfPublicLabel = UILabel()
    let locationLabel = UILabel()
    let downloadsLabel = UILabel()

// MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

// MARK: - UI

    private func setupView(){

        view.backgroundColor = .white
        photoImage.layer.cornerRadius = 100
        photoImage.clipsToBounds = true
        photoImage.contentMode = .scaleAspectFill

        [nameAuthorLabel, dateOfPublicLabel, locationLabel, downloadsLabel].forEach{
            $0.textAlignment = .center
            $0.textColor = .black
        }

        [photoImage, nameAuthorLabel, dateOfPublicLabel, locationLabel, downloadsLabel].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}

        view.addSubview(photoImage)
        NSLayoutConstraint.activate([
            photoImage.heightAnchor.constraint(equalToConstant: 200),
            photoImage.widthAnchor.constraint(equalToConstant: 200),
            photoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            photoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(nameAuthorLabel)
        NSLayoutConstraint.activate([
            nameAuthorLabel.heightAnchor.constraint(equalToConstant: 50),
            nameAuthorLabel.widthAnchor.constraint(equalToConstant: 400),
            nameAuthorLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 20),
            nameAuthorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(dateOfPublicLabel)
        NSLayoutConstraint.activate([
            dateOfPublicLabel.heightAnchor.constraint(equalToConstant: 50),
            dateOfPublicLabel.widthAnchor.constraint(equalToConstant: 400),
            dateOfPublicLabel.topAnchor.constraint(equalTo: nameAuthorLabel.bottomAnchor, constant: 15),
            dateOfPublicLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.heightAnchor.constraint(equalToConstant: 50),
            locationLabel.widthAnchor.constraint(equalToConstant: 400),
            locationLabel.topAnchor.constraint(equalTo: dateOfPublicLabel.bottomAnchor, constant: 15),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(downloadsLabel)
        NSLayoutConstraint.activate([
            downloadsLabel.heightAnchor.constraint(equalToConstant: 50),
            downloadsLabel.widthAnchor.constraint(equalToConstant: 200),
            downloadsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 15),
            downloadsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

//
//  InternationalController.swift
//  PhotoTestProject
//
//  Created by Василий on 22.01.2022.
//

import UIKit

final class MoreController: UIViewController {

// MARK: - properties

    let photoCollection = PhotoCollectionView()
    let photoTable = PhotoTableView()

    let photo = UIImageView()
    let nameAuthorLabel = UILabel()
    let dateOfPublicLabel = UILabel()
    let locationLabel = UILabel()
    let downloadsLabel = UILabel()
    let addButton = UIButton()

// MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

// MARK: - business logic

    @objc func buttonTapped(_sender: UIButton){
        addButton.backgroundColor = .green
        addButton.setTitle("Готово!", for: .normal)
        addQuestion()
    }

    func addQuestion(){}


// MARK: - UI

    private func setupView(){

        view.backgroundColor = .white

        photo.layer.cornerRadius = 100
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFill

        addButton.setTitle("Сохранить фото", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = .yellow
        addButton.layer.cornerRadius = 5
        addButton.addTarget(self, action: #selector(buttonTapped(_sender:)), for: .touchUpInside)

        [nameAuthorLabel, dateOfPublicLabel, locationLabel, downloadsLabel].forEach{
            $0.textAlignment = .center
            $0.textColor = .black
        }

        [photo, nameAuthorLabel, dateOfPublicLabel, locationLabel, downloadsLabel, addButton].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}

        view.addSubview(photo)
        NSLayoutConstraint.activate([
            photo.heightAnchor.constraint(equalToConstant: 200),
            photo.widthAnchor.constraint(equalToConstant: 200),
            photo.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            photo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(nameAuthorLabel)
        NSLayoutConstraint.activate([
            nameAuthorLabel.heightAnchor.constraint(equalToConstant: 50),
            nameAuthorLabel.widthAnchor.constraint(equalToConstant: 400),
            nameAuthorLabel.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 20),
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
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 70),
            addButton.widthAnchor.constraint(equalToConstant: 250),
            addButton.topAnchor.constraint(equalTo: downloadsLabel.bottomAnchor, constant: 120),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

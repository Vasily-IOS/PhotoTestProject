//
//  PhotoTableViewController.swift
//  PhotoTestProject
//
//  Created by Василий on 20.01.2022.
//

import UIKit

final class PhotoTableView: UITableViewController {

// MARK: - properties

    let photoCollectionVc = PhotoCollectionView()
    let networkLayer = NetworkLayer()
    
    private var reuseId = "reuseId"
    var users = [Results]()

// MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        load()
    }

// MARK: - business logic

    private func load(){

    }

// MARK: - UI
    
    private func setupView(){
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LovelyPhotoCell.self, forCellReuseIdentifier: reuseId)
    }

// MARK: - tableViewDelegate & tableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? LovelyPhotoCell
        else { return UITableViewCell() }
        let result = users[indexPath.row]
        cell.configure(url: result.urls.regular, name: result.user.name ?? "")
        return cell

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoreController()
        guard let url = URL(string: self.users[indexPath.row].user.profile_image.large) else { return }
        vc.photo.kf.setImage(with: url)
        vc.nameAuthorLabel.text = "Пользователь: \(self.users[indexPath.row].user.name)"
        vc.dateOfPublicLabel.text = "Дата публикации: \(self.users[indexPath.row].created_at)"
        vc.locationLabel.text = "Локация: \(self.users[indexPath.row].user.location ?? "Нет данных")"
        vc.downloadsLabel.text = "Загрузки: \(self.users[indexPath.row].likes)"
        present(vc, animated: true)
    }
    
}

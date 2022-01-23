//
//  PhotoTableViewController.swift
//  PhotoTestProject
//
//  Created by Василий on 20.01.2022.
//

import UIKit

final class PhotoTableViewController: UITableViewController {

// MARK: - properties

    let networkLayer = NetworkLayer()
    let reuseId = "reuseId"

// MARK: - lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

// MARK: - UI
    
    private func setupView(){
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavouritePhotoTableViewCell.self, forCellReuseIdentifier: reuseId)
    }

// MARK: - tableViewDelegate & tableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavouriteProvider.shared.favourite.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? FavouritePhotoTableViewCell
        else { return UITableViewCell() }
        let result = FavouriteProvider.shared.favourite[indexPath.row]
        cell.configure(url: result.urls.regular, name: result.user.name)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = JustInfoViewController()
        guard let url = URL(string: FavouriteProvider.shared.favourite[indexPath.row].user.profile_image.large) else { return }
        vc.photoImage.kf.setImage(with: url)
        vc.nameAuthorLabel.text = "Пользователь: \(FavouriteProvider.shared.favourite[indexPath.row].user.name)"
        vc.dateOfPublicLabel.text = "Дата публикации: \(FavouriteProvider.shared.favourite[indexPath.row].created_at)"
        vc.locationLabel.text = "Локация: \(FavouriteProvider.shared.favourite[indexPath.row].user.location ?? "Нет данных")"
        vc.downloadsLabel.text = "Загрузки: \(FavouriteProvider.shared.favourite[indexPath.row].likes)"
        present(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavouriteProvider.shared.favourite.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
            self.tableView.reloadData()
        }
    }

}

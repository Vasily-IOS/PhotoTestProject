//
//  PhotoViewController.swift
//  PhotoTestProject
//
//  Created by Василий on 20.01.2022.
//

import UIKit
import Kingfisher

class PhotoCollectionView: UIViewController {

// MARK: - properties

    private var collectionView: UICollectionView?

    let networkLayer = NetworkLayer()
    let searchBar = UISearchBar()
    var result = [Results]()

// MARK: - lifecycle

    override func viewDidLoad(){
        setupView()
        load()
    }

    override func viewDidLayoutSubviews(){
        searchBar.becomeFirstResponder()
    }

// MARK: - business logic

    private func load(){
        networkLayer.fetchData(completion: { [weak self] results in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let success):
                DispatchQueue.main.async {
                    self?.result = success
                    self?.collectionView?.reloadData()
                }
            }
        })
    }

// MARK: - UI

    private func setupView(){
        searchBar.placeholder = "Тема для поиска.."
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: Int(view.frame.size.width/2), height: Int(view.frame.size.width/2))

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate =  self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")

        view.addSubview(collectionView)
        self.collectionView = collectionView
        self.collectionView?.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height)
    }

}

// MARK: - extensions

extension PhotoCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell
        else { return UICollectionViewCell() }
        let imageUrl = result[indexPath.row].urls.regular
        cell.configure(with: imageUrl)
        return cell
    }
}

extension PhotoCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let vc = MoreController()
        guard let url = URL(string: self.result[indexPath.row].user.profile_image.large) else { return }
        vc.photo.kf.setImage(with: url)
        vc.nameAuthorLabel.text = "Пользователь: \(self.result[indexPath.row].user.name)"
        vc.dateOfPublicLabel.text = "Дата публикации: \(self.result[indexPath.row].created_at)"
        vc.locationLabel.text = "Локация: \(self.result[indexPath.row].user.location ?? "Нет данных")"
        vc.downloadsLabel.text = "Загрузки: \(self.result[indexPath.row].likes)"
        present(vc, animated: true)
    }
}


extension PhotoCollectionView: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
        result = []
        collectionView?.reloadData()
            networkLayer.fetchSearchData(query: text, completion: { [weak self] results in
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let success):
                    DispatchQueue.main.async {
                        self?.result = success
                        self?.collectionView?.reloadData()
                    }
                }
            })
        }
    }

}

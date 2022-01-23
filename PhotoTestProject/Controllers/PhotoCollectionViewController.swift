//
//  PhotoViewController.swift
//  PhotoTestProject
//
//  Created by Василий on 20.01.2022.
//

import UIKit
import Kingfisher

class PhotoCollectionViewController: UIViewController {

// MARK: - properties

    private var collectionView: UICollectionView?

    let networkLayer = NetworkLayer()
    let searchBar = UISearchBar()
    var photo = [Photo]()

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
                    self?.photo = success
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
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")

        view.addSubview(collectionView)
        self.collectionView = collectionView
        self.collectionView?.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height)
    }
}

// MARK: - extensions

extension PhotoCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell
        else { return UICollectionViewCell() }
        let imageUrl = photo[indexPath.row].urls.regular
        cell.configure(with: imageUrl)
        return cell
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let vc = InfoViewController(photo: photo[indexPath.row])
        guard let url = URL(string: self.photo[indexPath.row].user.profile_image.large) else { return }
        vc.photoImage.kf.setImage(with: url)
        vc.nameAuthorLabel.text = "Пользователь: \(self.photo[indexPath.row].user.name)"
        vc.dateOfPublicLabel.text = "Дата публикации: \(self.photo[indexPath.row].created_at)"
        vc.locationLabel.text = "Локация: \(self.photo[indexPath.row].user.location ?? "Нет данных")"
        vc.downloadsLabel.text = "Загрузки: \(self.photo[indexPath.row].likes)"
        present(vc, animated: true)
    }
}

extension PhotoCollectionViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
        photo = []
        collectionView?.reloadData()
            networkLayer.fetchSearchData(query: text, completion: { [weak self] results in
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let success):
                    DispatchQueue.main.async {
                        self?.photo = success
                        self?.collectionView?.reloadData()
                    }
                }
            })
        }
    }

}

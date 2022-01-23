//
//  LovelyPhotoCell.swift
//  PhotoTestProject
//
//  Created by Василий on 22.01.2022.
//

import UIKit
import Kingfisher

final class LovelyPhotoCell: UITableViewCell {

    private let reuseId = "reuseId"
    let photoImage = UIImageView()
    let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        nameLabel.text = nil
        photoImage.image = nil
    }

    private func setupView(){
        photoImage.layer.cornerRadius = 35
        photoImage.clipsToBounds = true
        photoImage.contentMode = .scaleAspectFill

        [photoImage, nameLabel].forEach{$0.translatesAutoresizingMaskIntoConstraints = false }

        contentView.addSubview(photoImage)
        NSLayoutConstraint.activate([
            photoImage.heightAnchor.constraint(equalToConstant: 70),
            photoImage.widthAnchor.constraint(equalToConstant: 70),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 120),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(url: String, name: String){
        guard let url = URL(string: url) else { return }
        DispatchQueue.main.async {
            self.nameLabel.text = name
            self.photoImage.kf.setImage(with: url)
        }
    }

}

//
//  PhotoCell.swift
//  PhotoTestProject
//
//  Created by Василий on 22.01.2022.
//

import UIKit
import Kingfisher

final class PhotoCollectionViewCell: UICollectionViewCell {

    let reuseId = "photoCell"
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func configure(with url: String){
        guard let url = URL(string: url) else { return }
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: url)
        }
    }

}

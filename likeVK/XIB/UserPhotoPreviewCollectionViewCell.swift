//
//  UserPhotoPreviewCollectionViewCell.swift
//  likeVK
//
//  Created by Jambau on 18.11.2020.
//

import UIKit

class UserPhotoPreviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
    }

    private func setupImageView() {
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
    }
}

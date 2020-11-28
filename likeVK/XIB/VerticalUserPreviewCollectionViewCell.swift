//
//  VerticalUserPreviewCollectionViewCell.swift
//  likeVK
//
//  Created by Jambau on 29.10.2020.
//

import UIKit

class VerticalUserPreviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var surnameTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupProfilePhotoImageView()
    }

    private func setupProfilePhotoImageView() {
        profilePhotoImageView.layer.cornerRadius = 35
    }
}

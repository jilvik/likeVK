//
//  HorizontalUserPreviewTableViewCell.swift
//  likeVK
//
//  Created by Jambau on 09.11.2020.
//

import UIKit

class HorizontalUserPreviewTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var surnameNameTextLabel: UILabel!
    @IBOutlet weak var cityTextLabel: UILabel!
    @IBOutlet weak var actionImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupProfilePhotoImageView()
    }
    
    private func setupProfilePhotoImageView() {
        profilePhotoImageView.layer.cornerRadius = 30
    }
}

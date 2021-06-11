//
//  ImageCell.swift
//  uipagecontrol
//
//  Created by Şule Turp on 19.03.2021.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    func setup(with image: UIImage) {
        imageView.image = image
    }
}

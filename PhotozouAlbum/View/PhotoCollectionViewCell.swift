//
//  SmallPhotoCollectionViewCell.swift
//  PhotozouAlbum
//
//  Created by 井草俊輔 on 2019/06/10.
//  Copyright © 2019 井草俊輔. All rights reserved.
//

import UIKit
import Nuke

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var photoImage: UIImageView!
    
    func updateCell(_ imageURL: String) {
        Nuke.loadImage(with: URL(string: imageURL)!, into: photoImage)
        photoImage.contentMode = .scaleAspectFill
        photoImage.layer.cornerRadius = 5
    }
    
}

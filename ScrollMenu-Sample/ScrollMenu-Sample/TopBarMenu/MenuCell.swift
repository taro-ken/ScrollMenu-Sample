//
//  MenuCell.swift
//  ScrollMenu-Sample
//
//  Created by 木元健太郎 on 2022/08/11.
//

import UIKit

final class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: MenuCellModel) {
        menuImage.image = model.image
        menuName.text = model.name
    }

}

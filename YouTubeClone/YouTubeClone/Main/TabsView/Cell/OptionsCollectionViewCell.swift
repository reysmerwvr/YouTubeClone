//
//  OptionsCollectionViewCell.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 7/25/22.
//

import UIKit

class OptionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(option: String) {
        titleLabel.text = option
    }
}

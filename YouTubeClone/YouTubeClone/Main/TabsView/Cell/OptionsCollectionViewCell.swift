//
//  OptionsCollectionViewCell.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 7/25/22.
//

import UIKit

class OptionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override var isSelected: Bool {
        didSet {
            highlightTitle(isSelected ? .whiteColor : .grayColor)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func highlightTitle(_ color: UIColor) {
        titleLabel.textColor = color
    }
    
    func configCell(option: String) {
        titleLabel.text = option
    }
}

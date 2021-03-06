//
//  PlayListCell.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 6/1/22.
//

import UIKit

class PlayListCell: UITableViewCell {

    @IBOutlet weak var videoImage: UIImageView!

    @IBOutlet weak var videoTitle: UILabel!

    @IBOutlet weak var videoCount: UILabel!

    @IBOutlet weak var videoCountOverlay: UILabel!

    @IBOutlet weak var dotsImage: UIImageView!
    
    var didTapDotsButton: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        selectionStyle = .none
        dotsImage.image = .dotsImage
        dotsImage.tintColor = .whiteColor
    }
    
    @IBAction func onDotsButtonTapped(_ sender: Any) {
        if let tap = didTapDotsButton {
            tap()
        }
    }
    
    func configCell(model: PlayListModel.Item) {
        videoTitle.text = model.snippet.title
        let itemCount = String(model.contentDetails.itemCount)
        videoCount.text = "\(itemCount) videos"
        videoCountOverlay.text = itemCount
        
        let imageUrl = model.snippet.thumbnails.medium.url
        if let url = URL(string: imageUrl) {
            videoImage.kf.setImage(with: url)
        }
    }
    
}

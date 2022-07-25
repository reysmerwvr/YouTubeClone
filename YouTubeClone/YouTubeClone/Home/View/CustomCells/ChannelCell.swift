//
//  ChannelCell.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 6/1/22.
//

import UIKit
import Kingfisher

class ChannelCell: UITableViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var channelTitle: UILabel!
    
    @IBOutlet weak var bellImage: UIImageView!
    
    @IBOutlet weak var subscribers: UILabel!
    
    @IBOutlet weak var channelDescription: UILabel!
    
    @IBOutlet weak var subscribe: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    func configView () {
        selectionStyle = .none
        bellImage.image = .bellImage
        bellImage.tintColor = .grayColor
        profileImage.layer.cornerRadius = 51/2
    }
    
    func configCell(model: ChannelModel.Item) {
        channelDescription.text = model.snippet.snippetDescription
        subscribers.text = "\(model.statistics.subscriberCount) subscribers - \(model.statistics.videoCount) videos"
        channelTitle.text = model.snippet.title
        
        if let bannerUrl = model.brandingSettings?.image.bannerExternalURL, let url = URL(string: bannerUrl) {
            bannerImage.kf.setImage(with: url)
        }
        
        let imageUrl = model.snippet.thumbnails.medium.url
        guard let url = URL(string: imageUrl) else { return }
        profileImage.kf.setImage(with: url)
    }
    
}

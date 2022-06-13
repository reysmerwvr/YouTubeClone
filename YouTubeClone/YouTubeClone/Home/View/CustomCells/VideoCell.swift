//
//  VideoCell.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 6/1/22.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var videoName: UILabel!
    
    @IBOutlet weak var channelName: UILabel!
    
    @IBOutlet weak var viewsCount: UILabel!

    @IBOutlet weak var dotsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        selectionStyle = .none
        dotsImage.image = UIImage(named: "dots")?.withRenderingMode(.alwaysTemplate)
        dotsImage.tintColor = UIColor(named: "whiteColor")
    }
    
    func configCell(model: Any) {
        if let video = model as? VideoModel.Item {
            if let imageUrl = video.snippet?.thumbnails.medium?.url, let url = URL(string: imageUrl) {
                videoImage.kf.setImage(with: url)
            }
            videoName.text = video.snippet?.title ?? ""
            channelName.text = video.snippet?.channelTitle ?? ""
            viewsCount.text = "\(video.statistics?.viewCount ?? "0") views - 3 months ago"
        } else if let playlistItems = model as? PlayListItemModel.Item {
            if let imageUrl = playlistItems.snippet?.thumbnails.medium?.url, let url = URL(string: imageUrl) {
                videoImage.kf.setImage(with: url)
            }
            videoName.text = playlistItems.snippet?.title ?? ""
            channelName.text = playlistItems.snippet?.channelTitle ?? ""
            viewsCount.text = "0 views - 3 months ago"
        }
    }
}

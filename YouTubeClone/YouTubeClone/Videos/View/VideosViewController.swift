//
//  VideosViewController.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/27/22.
//

import UIKit

class VideosViewController: UIViewController {

    @IBOutlet weak var videosTableView: UITableView!
    lazy var presenter = VideosPresenter(delegate: self)
    var videoList: [VideoModel.Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()

        Task {
            await presenter.getVideos()
        }
    }
    
    func configTableView() {
        videosTableView.register(cell: VideoCell.self)
        videosTableView.separatorColor = .clear
        videosTableView.delegate = self
        videosTableView.dataSource = self
    }
}

extension VideosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(for: VideoCell.self, for: indexPath)
        cell.didTapDotsButton = {[weak self] in
            self?.configButtonSheet()
        }
        cell.configCell(model: video)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
    func configButtonSheet() {
        let vc = BottomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
}

extension VideosViewController: VideosViewProtocol {
    func getVideos(videoList: [VideoModel.Item]) {
        self.videoList = videoList
        videosTableView.reloadData()
    }
}

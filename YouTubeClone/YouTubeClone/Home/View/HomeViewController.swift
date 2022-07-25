//
//  HomeViewController.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/27/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var homeTableView: UITableView!
    lazy var presenter = HomePresenter(delegate: self)
    private var objectList: [[Any]] = []
    private var sectionTitleList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        
        Task {
            await presenter.getHomeObjects()
        }
    }
    
    func configTableView() {
        homeTableView.register(cell: ChannelCell.self)
        homeTableView.register(cell: VideoCell.self)
        homeTableView.register(cell: PlayListCell.self)
        homeTableView.registerFromClass(headerFooterView: SectionTitleView.self)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.separatorColor = .clear
        homeTableView.contentInset = UIEdgeInsets(top: -15, left: 0, bottom: -80, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        if velocity < -5 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else if velocity > 5 {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}


extension HomeViewController: HomeViewProtocol {
    func getData(list: [[Any]], sectionTitleList: [String]) {
        objectList = list
        self.sectionTitleList = sectionTitleList
        homeTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectList[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = objectList[indexPath.section]
        if let channel = item as? [ChannelModel.Item] {
            let channelCell = tableView.dequeueReusableCell(for: ChannelCell.self, for: indexPath)
            channelCell.configCell(model: channel[indexPath.row])
            return channelCell
        } else if let playlistItems = item as? [PlayListItemModel.Item] {
            guard let playlistItemsCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else {
                return UITableViewCell()
            }
            playlistItemsCell.configCell(model: playlistItems[indexPath.row])
            return playlistItemsCell
        } else if let videos = item as? [VideoModel.Item] {
            let videosCell = tableView.dequeueReusableCell(for: VideoCell.self, for: indexPath)
            videosCell.didTapDotsButton = {[weak self] in
                self?.configButtonSheet()
            }
            videosCell.configCell(model: videos[indexPath.row])
            return videosCell
        } else if let playlist = item as? [PlayListModel.Item] {
            let playlistCell = tableView.dequeueReusableCell(for: PlayListCell.self, for: indexPath)
            playlistCell.didTapDotsButton = {[weak self] in
                self?.configButtonSheet()
            }
            playlistCell.configCell(model: playlist[indexPath.row])
            return playlistCell
        }
        
        return UITableViewCell()
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return sectionTitleList[section]
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 || indexPath.section == 2 {
            return 95.0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(SectionTitleView.self)") as? SectionTitleView else {
            return nil
        }
        sectionView.title.text = sectionTitleList[section]
        sectionView.configView()
        return sectionView
    }
    
    func configButtonSheet() {
        let vc = BottomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
}

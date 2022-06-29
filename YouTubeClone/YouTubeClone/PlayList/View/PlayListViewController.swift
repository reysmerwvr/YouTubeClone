//
//  PlayListViewController.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/27/22.
//

import UIKit

class PlayListViewController: UIViewController {
    
    @IBOutlet weak var playListTableView: UITableView!
    lazy var presenter = PlayListPresenter(delegate: self)
    var playList: [PlayListModel.Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        
        Task {
            await presenter.getPlayList()
        }
    }
    
    func configTableView() {
        let nibPlaylist = UINib(nibName: "\(PlayListCell.self)", bundle: nil)
        playListTableView.register(nibPlaylist, forCellReuseIdentifier: "\(PlayListCell.self)")
        playListTableView.separatorColor = .clear
        playListTableView.delegate = self
        playListTableView.dataSource = self
    }
}

extension PlayListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playList = playList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PlayListCell.self)", for: indexPath) as? PlayListCell else {
            return UITableViewCell()
        }
        cell.didTapDotsButton = {[weak self] in
            self?.configButtonSheet()
        }
        cell.configCell(model: playList)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func configButtonSheet() {
        let vc = BottomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
}

extension PlayListViewController: PlayListViewProtocol {
    func getPlayList(playList: [PlayListModel.Item]) {
        self.playList = playList
        playListTableView.reloadData()
    }
}

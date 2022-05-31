//
//  HomeViewController.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/27/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var presenter = HomePresenter(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await presenter.getHomeObjects()
        }
    }
}

extension HomeViewController: HomeViewProtocol {
    func getData(list: [[Any]]) {
        print("list", list)
    }
}

//
//  MainViewController.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/27/22.
//

import UIKit

class MainViewController: BaseViewController {
    var rootPageViewController: RootPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RootPageViewController {
            destination.rootPageDelegate = self
            rootPageViewController = destination
        }
    }
}

extension MainViewController: RootPageProtocol {
    func currentPage(_ index: Int) {
        print(index)
    }
}

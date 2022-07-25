//
//  MainViewController.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/27/22.
//

import UIKit

class MainViewController: BaseViewController {
    @IBOutlet weak var tabsView: TabsView!
    var rootPageViewController: RootPageViewController!
    private var options: [String] = ["HOME", "VIDEOS", "PLAYLIST", "CHANNEL", "ABOUT"]
    var currentPageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        tabsView.buildView(delegate: self, options: options)
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

extension MainViewController: TabsViewProtocol {
    func didSelectOption(index: Int) {
        print("index: ", index)
        
        var direction: UIPageViewController.NavigationDirection = .forward
        if index < currentPageIndex {
            direction = .reverse
        }
        rootPageViewController.setViewControllersFromIndex(index: index, direction: direction)
        currentPageIndex = index
    }
}

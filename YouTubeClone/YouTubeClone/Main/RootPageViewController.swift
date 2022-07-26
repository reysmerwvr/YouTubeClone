//
//  RootPageViewController.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/27/22.
//

import UIKit

enum ScrollDirection{
    case goingLeft
    case goingRight
}

protocol RootPageProtocol: AnyObject {
    func currentPage(_ index: Int)
    func scrollDetails(direction: ScrollDirection, percent: CGFloat, index: Int)
}

class RootPageViewController: UIPageViewController {
    
    var subViewControllers = [UIViewController]()
    var currentIndex = 0
    weak var rootPageDelegate: RootPageProtocol?
    var startOffset : CGFloat = 0.0
    var currentPage : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        rootPageDelegate?.currentPage(0)
        setupViewControllers()
        setScrollViewDelegate()
    }
    
    private func setupViewControllers() {
        subViewControllers = [
            HomeViewController(),
            VideosViewController(),
            PlayListViewController(),
            ChannelsViewController(),
            AboutViewController(),
        ]
        
        _ = subViewControllers.enumerated().map({ $0.element.view.tag = $0.offset })
        
        setViewControllersFromIndex(index: 0, direction: .forward, animated: true)
    }
    
    func setViewControllersFromIndex(index: Int, direction: UIPageViewController.NavigationDirection, animated: Bool = true) {
        setViewControllers([subViewControllers[index]], direction: direction, animated: animated)
    }
    
    func setScrollViewDelegate() {
        guard let scrollView = view.subviews.filter({ $0 is UIScrollView}).first as? UIScrollView else { return }
        scrollView.delegate = self
    }
    
    //    override func setViewControllers(_ viewControllers: [UIViewController]?, direction: UIPageViewController.NavigationDirection, animated: Bool, completion: ((Bool) -> Void)? = nil) {
    //        <#code#>
    //    }
}

extension RootPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = subViewControllers.firstIndex(of: viewController) ?? 0
        if index <= 0 {
            return nil
        }
        return subViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = subViewControllers.firstIndex(of: viewController) ?? 0
        if index >= subViewControllers.count - 1 {
            return nil
        }
        return subViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let index = pageViewController.viewControllers?.first?.view.tag {
            currentIndex = index
            rootPageDelegate?.currentPage(index)
        }
    }
}

extension RootPageViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.x
        print("startOffset: \(startOffset)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var direction = 0 //Scroll stopped
        if startOffset < scrollView.contentOffset.x{
            direction = 1 //right
        }else if startOffset > scrollView.contentOffset.x{
            direction = -1 //left
        }
        
        let positionFromStartOfCurrentPage = abs(startOffset - scrollView.contentOffset.x)
        let percent = positionFromStartOfCurrentPage /  self.view.frame.width
        rootPageDelegate?.scrollDetails(direction: (direction == 1) ? .goingRight : .goingLeft, percent: percent, index: currentPage)
        print("percent: \(percent)")
        print("direction: \(direction)")
    }
}

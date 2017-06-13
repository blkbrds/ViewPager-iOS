//
//  TabbarCustomViewController.swift
//  CustomTabbar
//
//  Created by Tuan Mai A. on 5/30/17.
//  Copyright © 2017 Tuan Mai A. All rights reserved.
//

import UIKit

protocol TabbarCustomViewControllerDatasource: NSObjectProtocol {
    func viewForItemInTabbar(index: Int, isSelect: Bool) -> UIView?
    func sizeForItemInTabbar(index: Int) -> CGSize
}

protocol TabbarCustomViewControllerDelegate: NSObjectProtocol {
    func tabBarController(_ tabBarController: TabbarCustomViewController, shouldSelect viewController: UIViewController) -> Bool
    func tabBarController(_ tabBarController: TabbarCustomViewController,_ viewController: UIViewController, didEndAnimation animation: Bool?)
}

class TabbarCustomViewController: UIViewController {
    
    
    fileprivate var pageView: UIPageViewController = UIPageViewController(transitionStyle: .scroll,
                                                                      navigationOrientation: .horizontal,
                                                                      options: nil)
    weak var datasource: TabbarCustomViewControllerDatasource?
    weak var delegate: TabbarCustomViewControllerDelegate?
    
    private var tabbarView: TabbarCustom = TabbarCustom()
    var viewControllers: [UIViewController] = []
    var selectedViewController: UIViewController?
    var selectedIndex: Int = 0
    var tabbarHeight: CGFloat = 44
    var isScroll = false
    
    var currentIndex = 0 {
        didSet {
            tabbarView.indexSelect = currentIndex
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view didLoad")
        setUp()
        setupConstraints()
        if isScroll {
            pageView.dataSource = self
            pageView.delegate = self
        }
        if !viewControllers.isEmpty {
            let vc = viewControllers[0]
            pageView.setViewControllers([vc], direction: .reverse, animated: false, completion: {(_) in
                self.delegate?.tabBarController(self, vc, didEndAnimation: true)
            })
            selectedViewController = viewControllers[0]
        }
        
        tabbarView.delegate = self
        tabbarView.datasource = self
        tabbarView.setup()
    }

    func setupConstraints() {
        
        pageView.view.translatesAutoresizingMaskIntoConstraints = false
        pageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pageView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pageView.view.bottomAnchor.constraint(equalTo: tabbarView.topAnchor).isActive = true
        
        tabbarView.translatesAutoresizingMaskIntoConstraints = false
        tabbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tabbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabbarView.heightAnchor.constraint(equalToConstant: tabbarHeight).isActive = true
        view.layoutSubviews()
        view.layoutIfNeeded()
    }
    
    private func setUp() {
        addChildViewController(pageView)
        view.addSubview(pageView.view)
        view.addSubview(tabbarView)
        tabbarView.numberItem = viewControllers.count
        tabbarView.indexSelect  = selectedIndex
        self.view.backgroundColor = UIColor.blue
    }
}

extension TabbarCustomViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentIndex + 1 < viewControllers.count {
            if delegate != nil && delegate?.tabBarController(self, shouldSelect: viewControllers[currentIndex + 1]) == false {
                return nil
            } else {
                return viewControllers[currentIndex + 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if currentIndex > 0 {
            if delegate != nil && delegate?.tabBarController(self, shouldSelect: viewControllers[currentIndex - 1]) == false {
                return nil
            } else {
                return viewControllers[currentIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let vc = pageViewController.viewControllers?.first,
        let index = viewControllers.index(of: vc) else { return }
        currentIndex = index
        selectedViewController = vc
        delegate?.tabBarController(self, vc, didEndAnimation: true)
    }
}
extension TabbarCustomViewController: TabbarCustomDatasource, TabbarCustomDelegate {
    
    func viewForItemInTabbar(index: Int, isSelect: Bool) -> UIView? {
        return datasource?.viewForItemInTabbar(index: index, isSelect: isSelect)
    }
    
    func sizeForItemInTabbar(index: Int) -> CGSize {
        return datasource?.sizeForItemInTabbar(index: index) ?? CGSize.zero
    }

    func didSelectItemInTabbar(index: Int) {
        if index < viewControllers.count {
            if index < currentIndex {
                if delegate == nil || delegate?.tabBarController(self, shouldSelect: viewControllers[index]) == true {
                    self.pageView.setViewControllers([viewControllers[index]],
                                                     direction: .reverse,
                                                     animated: true,
                                                     completion: {(_) in
                                                        self.delegate?.tabBarController(self, self.viewControllers[index], didEndAnimation: true)
                    })
                }
                selectedViewController = viewControllers[index]
            } else if index > currentIndex {
                
                if delegate == nil || delegate?.tabBarController(self, shouldSelect: viewControllers[index]) == true {
                    pageView.setViewControllers([viewControllers[index]],
                                                direction: .forward,
                                                animated: true,
                                                completion: {(_) in
                                                    self.delegate?.tabBarController(self, self.viewControllers[index], didEndAnimation: true)
                    })
                }
                
                selectedViewController = viewControllers[index]
            }
                currentIndex = index
            }
        }
}


extension TabbarCustomViewControllerDelegate {
    func tabBarController(_ tabBarController: TabbarCustomViewController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    func tabBarController(_ tabBarController: TabbarCustomViewController,_ viewController: UIViewController, didEndAnimation animation: Bool?) {
        
    }
}

//
//  ViewController.swift
//  ScrollMenu-Sample
//
//  Created by 木元健太郎 on 2022/08/11.
//

import UIKit

class HomeFeedController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    
    private let topBarMenuController = TopBarMenuController(collectionViewLayout: UICollectionViewFlowLayout())
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    let vc1 = UIStoryboard.init(name: "Page1", bundle: nil).instantiateInitialViewController() as! Page1ViewController
    let vc2 = UIStoryboard.init(name: "Page2", bundle: nil).instantiateInitialViewController() as! Page2ViewController
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.dataSource = self
        topBarMenuController.topBarMenuControllerDelegate = self
        pageViewController.setViewControllers([vc1], direction: .forward, animated: true, completion: nil)
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        
       
        
       let scrollView = pageViewController.view.subviews.compactMap { $0 as? UIScrollView }.first
       scrollView?.delegate = self
        setupTopBarMenuController()
        
    }
    
    private func setupTopBarMenuController() {
        var statusBar = UIApplication.shared.statusBarFrame.size.height
        var navigationBarHeigh = self.navigationController?.navigationBar.frame.size.height
        //  ナビゲーションバーの高さと色を設定
        let navBarController = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBarHeigh! + statusBar))
        view.addSubview(navBarController)
        navBarController.barTintColor = .darkGray
        //TopBarMenuControllerを設置する
        view.addSubview(topBarMenuController.view)
        topBarMenuController.view.anchor(top: navBarController.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 60, width: 0)
    }
}

extension HomeFeedController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        switch viewController {
        case vc1:
            return vc2
        default:
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        switch viewController {
        case vc2:
            return vc1
        default:
            return nil
        }
    }
}

extension HomeFeedController: TopBarMenuControllerDelegate {
    //メニューアイテムをタップした時に画面がスライドする機能
    func didTapMenu(indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            pageViewController.setViewControllers([vc1], direction: .reverse, animated: true, completion: nil)
        case 1:
            pageViewController.setViewControllers([vc2], direction: .forward, animated: true, completion: nil)
        default:
            break
        }
    }
}

extension HomeFeedController: UIScrollViewDelegate {
    //画面を横にスクロールした時にメニューバー内の下枠(青)が付いてくる仕様
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let offset = x / 2
        let hoge = x - view.frame.width
        print(offset)
        topBarMenuController.menuBottomLine.transform = CGAffineTransform(translationX: offset, y: 0)
}
    
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let x = targetContentOffset.pointee.x
//        let item = x / view.frame.width
//
//        topBarMenuController.menuBottomLine.transform = CGAffineTransform(translationX: item, y: 0)
        //     print(view.frame.width)
        //    let indexPath = IndexPath(item: Int(item), section: 0)
        //    topBarMenuController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}












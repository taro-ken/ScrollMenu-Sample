//
//  ViewController.swift
//  ScrollMenu-Sample
//
//  Created by 木元健太郎 on 2022/08/11.
//

import UIKit

final class HomeFeedController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let topBarMenuController = TopBarMenuController(collectionViewLayout: UICollectionViewFlowLayout())
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    let vc1 = UIStoryboard.init(name: "Page1", bundle: nil).instantiateInitialViewController() as! Page1ViewController
    let vc2 = UIStoryboard.init(name: "Page2", bundle: nil).instantiateInitialViewController() as! Page2ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarMenuController.topBarMenuControllerDelegate = self
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

extension HomeFeedController: TopBarMenuControllerDelegate {
    //メニューアイテムをタップした時に画面がスライドする機能
    func didTapMenu(indexPath: IndexPath) {
        scrollToPage(page: indexPath.item, animated: true)
    }
}

extension HomeFeedController: UIScrollViewDelegate {
    //画面を横にスクロールした時に青いViewが付いてくる仕様
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let offset = x / 2
        let hoge = x - view.frame.width
        print(offset)
        topBarMenuController.menuBottomLine.transform = CGAffineTransform(translationX: offset, y: 0)
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.bounds
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
}












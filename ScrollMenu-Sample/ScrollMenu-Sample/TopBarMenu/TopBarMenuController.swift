//
//  TopBarMenuController.swift
//  ScrollMenu-Sample
//
//  Created by 木元健太郎 on 2022/08/11.
//


import UIKit

protocol TopBarMenuControllerDelegate {
    func didTapMenu(indexPath: IndexPath)
}

final class TopBarMenuController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var topBarMenuControllerDelegate: TopBarMenuControllerDelegate?
    
    fileprivate let menuCell = "MenuCell"
    fileprivate let menuItem = [
        MenuCellModel.init(image: UIImage(named: "icon"), name: "page1"),
        MenuCellModel.init(image: UIImage(named: "icon"), name: "page2")
    ]
    
    //メニューバー内の青いライン
    let menuBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: menuCell, bundle: nil), forCellWithReuseIdentifier: menuCell)
        collectionView.alwaysBounceHorizontal = true
        
        //横にスクロールする機能
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        view.addSubview(menuBottomLine)
        menuBottomLine.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 2, width: 0)
        
        menuBottomLine.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 2).isActive = true
    }
    
    //menuItem配列の数を返す
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCell, for: indexPath) as? MenuCell else {
            return UICollectionViewCell()
        }
        cell.configure(model: menuItem[indexPath.item])
        return cell
    }
    
    //それぞれのセルサイズを配列の数に合わせる
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2, height: view.frame.height)
    }
    
    //メニューアイテムをタップした時の挙動
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        topBarMenuControllerDelegate?.didTapMenu(indexPath: indexPath)
    }
    
}

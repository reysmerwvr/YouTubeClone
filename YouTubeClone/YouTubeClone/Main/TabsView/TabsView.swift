//
//  TabsView.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 7/25/22.
//

import UIKit

protocol TabsViewProtocol: AnyObject {
    func didSelectOption(index: Int)
}

class TabsView: UIView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .backgroundColor
        
//        Register Cell
        collection.register(UINib(nibName: "\(OptionsCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(OptionsCollectionViewCell.self)")
        
        return collection
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configCollectionView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private var options: [String] = []
    weak private var delegate: TabsViewProtocol?
    
    func buildView(delegate: TabsViewProtocol, options: [String]) {
        self.delegate = delegate
        self.options = options
        collectionView.reloadData()
    }
    
    private func configCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

extension TabsView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(OptionsCollectionViewCell.self)", for: indexPath) as? OptionsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configCell(option: options[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectOption(index: indexPath.item)
    }
}

extension TabsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel()
        label.text = options[indexPath.item]
        label.font = UIFont.systemFont(ofSize: 16)
        let extraPadding: CGFloat = 20.0
        return CGSize(width: label.intrinsicContentSize.width + extraPadding, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

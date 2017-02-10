//
//  MovieListCollectionView.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/9/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class MovieListCollectionView: UICollectionView {
    //Layout Variables
    var cellsPerRow: Int = 2
    var cellHeight: CGFloat? = 300
    fileprivate let bottomSpaceBetweenCells: CGFloat = 10
    fileprivate let leftPadding: CGFloat = 10
    fileprivate let middleSpaceBetweenCells: CGFloat = 3
    fileprivate let rightPadding: CGFloat = 10
    fileprivate let topPadding: CGFloat = 10
    
    fileprivate let cellIdentifier = String(describing: MovieListCollectionCell.self)
    weak var listDelegate: MovieListViewDelegate?
    
    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
}

//MARK: Configuration
private extension MovieListCollectionView {
    func configure() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)

        delegate = self
        dataSource = self
        register(nib,
                 forCellWithReuseIdentifier: cellIdentifier)
        configureFlowLayout()
    }
    
    func configureFlowLayout() {
        let viewFlowLayout = UICollectionViewFlowLayout()
        
        viewFlowLayout.minimumInteritemSpacing = middleSpaceBetweenCells
        viewFlowLayout.minimumLineSpacing = bottomSpaceBetweenCells
        viewFlowLayout.sectionInset = UIEdgeInsetsMake(topPadding, leftPadding, 0, rightPadding)
        
        backgroundColor = UIColor.clear
        collectionViewLayout = viewFlowLayout
    }
}

// MARK: MovieListView
extension MovieListCollectionView: MovieListView {
    func cell(atIndex index: Int) -> MovieListCell? {
        return cellForItem(at: IndexPath(item: index, section: 0)) as? MovieListCell
    }
}

// MARK: UICollectionViewDataSource
extension MovieListCollectionView :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDelegate?.numberOfCells() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieListCollectionCell
        
        listDelegate?.configure(cell: cell, atIndex: indexPath.row)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension MovieListCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listDelegate?.didSelectRow(atIndex: indexPath.row)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MovieListCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = self.cellsPerRow == 0 ? 1 : self.cellsPerRow
        let collectionWidth = collectionView.bounds.width
        let blankSpaces = leftPadding + middleSpaceBetweenCells
        let width = collectionWidth / CGFloat(cellsPerRow) - blankSpaces
        
        return CGSize(width: width, height: cellHeight!)
    }
}
